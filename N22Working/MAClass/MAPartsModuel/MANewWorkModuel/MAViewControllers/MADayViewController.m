//
//  MADayViewController.m
//  N22Working
//
//  Created by nwk on 2017/4/1.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MADayViewController.h"
#import "MJExtension.h"
#import "MATools.h"
#import "MAFNetworkingTool.h"
#import "MABaseModel.h"
#import "MADayDetail.h"
#import "MADayDetailTableViewCell.h"
#import "MANewWorkViewController.h"
#import "MADayViewModel.h"

@interface MADayViewController ()<UITableViewDelegate,UITableViewDataSource, MANewWorkDelegate,MADayDetailDelegate>
{
    
}
@property (strong, nonatomic) MADayViewModel *dayViewModel;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@end

@implementation MADayViewController
#define MAWorkDetailCell @"MAWorkDetailCell"

+ (instancetype)newDayViewController:(NSDate *)date {
    MADayViewController *dayVc = [[MADayViewController alloc] init];
    dayVc.dayViewModel.currentDate = date;
    dayVc.title = dateFormatter(date, @"yyyy-MM-dd");
    return dayVc;
}

- (MADayViewModel *)dayViewModel {
    if (!_dayViewModel) {
        _dayViewModel = [[MADayViewModel alloc] init];
    }
    
    return _dayViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitItemClicked:)];
    
    UIBarButtonItem *newItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(newItemClicked:)];
    
    self.navigationItem.rightBarButtonItems = @[newItem, submit];
    
    [self setupDayViewModel];
}

- (void)setupDayViewModel {
    self.dayViewModel.dayTableView = self.detailTableView;
    [self.dayViewModel requestToServerGetWorkingData:self.dayViewModel.currentDate];
}


- (void)submitItemClicked:(id)sender {
    //TODO 提交
    NSString *jsonStr = [self.dayViewModel prepareRequestModel];

    NSLog(@"----json %@",jsonStr);
    [self.dayViewModel requestToServerAddWorking:jsonStr];
    
}

- (void)newItemClicked:(id)sender {
    //TODO 添加
    
    MANewWorkViewController *newWork = [[MANewWorkViewController alloc] initWithNibName:@"MANewWorkViewController" bundle:nil];
    newWork.delegate = self;
    [self.navigationController pushViewController:newWork animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dayViewModel.dayArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MADayDetailTableViewCell *cell = (MADayDetailTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell cellHeight];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"第 %zd 项",section+1];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MADayDetailTableViewCell *cell = [self.dayViewModel dequeueDayDetailTableViewCell:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - MANewWorkDelegate

- (void)replaceWorkContent:(MADayDetail *)dayDetail indexPath:(NSIndexPath *)indexPath{
    [self.dayViewModel relpaceDayDetailWorking:dayDetail indexPath:indexPath];
}

#pragma mark - MADayDetailDelegate

- (void)updateCurrentDayWorking:(NSIndexPath *)indexPath {
    MADayDetail *detail = self.dayViewModel.dayArray[indexPath.section];
    
    MANewWorkViewController *newWorkController = [[MANewWorkViewController alloc] initNewWorkWithCellModel:detail indexPath:indexPath];
    newWorkController.delegate = self;
    [self.navigationController pushViewController:newWorkController animated:YES];
}

- (void)opinionCurrentDayWorking:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
