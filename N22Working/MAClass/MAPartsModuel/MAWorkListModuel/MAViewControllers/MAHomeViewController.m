//
//  MAHomeViewController.m
//  N22Working
//
//  Created by nwk on 2017/3/31.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAHomeViewController.h"
#import "MJExtension.h"
#import "MATools.h"
#import "MAFNetworkingTool.h"
#import "MABaseModel.h"
#import "MAMonth.h"
#import <EventKit/EventKit.h>
#import "FSCalendar.h"
#import "MAMonthItemBo.h"
#import "Masonry.h"
#import "MADayViewController.h"
#import "MACodeTable.h"
#import "LoginViewController.h"
#import "MAInstance.h"
#import <MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN
@interface MAHomeViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance,UITableViewDataSource,UITableViewDelegate>
{
    NSDate *currentDate;
}

@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) UITableView *workTableView;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UIView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@end

NS_ASSUME_NONNULL_END

@implementation MAHomeViewController

#define MAWorkTableViewCell @"MAWorkTableViewCell"

- (void)workingBtnPressed:(NSDate *)date {
    NSDictionary *monthDic = [MAHomeViewController getMonthBeginAndEndWith:date];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"starttime"] = monthDic[@"begin"];
    dic[@"endtime"] = monthDic[@"end"];
    dic[@"type"] = @"1";
    
    NSString *jsonStr = [dic mj_JSONString];
    

    loadingForTextToView(@"正在查询", self.view);
    
    [MAFNetworkingTool POST:HttpTagAllList parameters:@{@"opt":jsonStr} successBlock:^(id responesObj) {
        
        NSLog(@"----%@",[responesObj mj_JSONString]);
        
        [MABaseModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"MAMonth"};
        }];
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        if (response.success) {
            
            self.dataSource = [NSMutableArray arrayWithArray:response.data];
            
            [self.calendar reloadData];
            [self.workTableView reloadData];
        }
        closeHUDToView(self.view);
        
        [self.workTableView.mj_header endRefreshing];
        [self.workTableView.mj_footer endRefreshing];
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
        closeHUDToView(self.view);
        [self.workTableView.mj_header endRefreshing];
        [self.workTableView.mj_footer endRefreshing];
    }];
}


- (void)loadCalendarView {
    
    self.calendarView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.calendarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.calendarView];
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.calendarView.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerDateFormat = @"yyyy-MM";
//    calendar.firstWeekday = 2;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.calendarView addSubview:calendar];
    self.calendar = calendar;
    
    height = CGRectGetHeight(self.calendarView.frame)-(CGRectGetMaxY(self.calendar.frame)+CGRectGetHeight(self.tabBarController.tabBar.frame));
    
    UITableView *workTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendar.frame), CGRectGetWidth(self.calendarView.frame), height) style:UITableViewStylePlain];
    workTableView.delegate = self;
    workTableView.dataSource = self;
    [self.calendarView addSubview:workTableView];
    
    self.workTableView = workTableView;
    
    self.workTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onMonthRefresh)];
    self.workTableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.workTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(lastMonthRefresh)];
    self.workTableView.mj_footer.automaticallyHidden = YES;
    self.workTableView.mj_footer.automaticallyChangeAlpha = YES;
}

- (void)onMonthRefresh {
    currentDate = [self convertDate:currentDate isLast:NO];
    
//    [self workingBtnPressed:currentDate];
    
    [self.calendar setCurrentPage:currentDate animated:YES];
}

- (void)lastMonthRefresh {
    currentDate = [self convertDate:currentDate isLast:YES];
    
//    [self workingBtnPressed:currentDate];
    
    [self.calendar setCurrentPage:currentDate animated:YES];
}

- (NSDate *)convertDate:(NSDate *)date isLast:(BOOL)islast{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:islast ? 1 : -1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:date options:0];
    
    return newdate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentDate = [NSDate date];
    
    [self loadCalendarView];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    if ([[MAInstance getInstance] isLogin]) {
        if (self.calendarView.hidden) {
            self.calendarView.hidden = NO;
            self.loginView.hidden = YES;
            [self setupWorkList];
        }
        
    } else {
        self.calendarView.hidden = YES;
        self.loginView.hidden = NO;
    }
}

- (void)setupWorkList {
    
    [self workingBtnPressed:currentDate];
    
    [MACodeTable getInstance];
    
    UIBarButtonItem *todayItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStylePlain target:self action:@selector(todayItemClicked:)];
    
    self.navigationItem.rightBarButtonItems = @[todayItem];
}

- (IBAction)btnLoginPressed:(id)sender {
    
    LoginViewController *viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Target actions

- (void)todayItemClicked:(id)sender
{
    [self.calendar setCurrentPage:[NSDate date] animated:YES];
}
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - <FSCalendarDelegate>

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"should select date %@",[self.dateFormatter stringFromDate:date]);
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    MADayViewController *dayViewController = [MADayViewController newDayViewController:date];
    
    [self.navigationController pushViewController:dayViewController animated:YES];
    
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
    
    [self workingBtnPressed:calendar.currentPage];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

#pragma mark - <FSCalendarDataSource>


- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"1970-01-01"];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"2099-12-31"];
}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    
    return [self isEventForDate:date]?[UIImage imageNamed:@"icon_footprint"]:nil;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource.firstObject itemBos].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MAWorkTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MAWorkTableViewCell];
    }
    
    MAMonthItemBo *itemBo = [self.dataSource.firstObject itemBos][indexPath.row];
    
    cell.textLabel.text = itemBo.item_date;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长：%@",itemBo.msg];
    cell.detailTextLabel.textColor=[UIColor grayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MAMonthItemBo *itemBo = [self.dataSource.firstObject itemBos][indexPath.row];
    
    NSDate *date = stringFormatterDate(itemBo.item_date, @"yyyy-MM-dd");
    
    MADayViewController *dayViewController = [MADayViewController newDayViewController:date];
    
    [self.navigationController pushViewController:dayViewController animated:YES];
}


- (BOOL)isEventForDate:(NSDate *)date {
    NSArray *itemBos = [self.dataSource.firstObject itemBos];
    
    for (MAMonthItemBo *itemBo in itemBos) {
        if ([self isOrderedSameWithDate:date dateStr:itemBo.item_date]) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)isOrderedSameWithDate:(NSDate *)date dateStr:(NSString *)dateStr {
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date1 = [dateformater dateFromString:dateStr];
    NSComparisonResult result = [date compare:date1];
    if (result==NSOrderedSame)
        return YES;
    
    return NO;
}

//获取一个月的第一天和最后一天
+ (NSDictionary *)getMonthBeginAndEndWith:(NSDate *)date{
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @{};
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    return @{@"begin":beginString,@"end":endString};
}
@end
