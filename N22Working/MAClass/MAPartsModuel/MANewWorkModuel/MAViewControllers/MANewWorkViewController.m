//
//  MANewWorkViewController.m
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewWorkViewController.h"
#import "UIView+Extension.h"
#import "MAWorkOptionTableViewCell.h"
#import "MAProjectListViewController.h"
#import "MATaskViewController.h"
#import "MATools.h"
#import "MADurationView.h"
#import "MATools.h"
#import <MJExtension.h>
#import "MAFNetworkingTool.h"
#import "MABaseModel.h"
#import "MATaskModel.h"

#import "MANewWorkViewModel.h"


@implementation MACellModel



@end

@interface MANewWorkViewController ()<UITableViewDelegate, UITableViewDataSource,MAProjectListDelegate,MATaskDelegate,MADurationDelegate, MAWorkOptionDelegate>
{
    NSIndexPath *preIndexPath;
}
@property (weak, nonatomic) IBOutlet UITableView *workTableView;

@property (strong, nonatomic) MADurationView *durationView;

@property (strong, nonatomic) MANewWorkViewModel *newWorkModelView;

@end

@implementation MANewWorkViewController

#define MANewWorkTableCell @"MANewWorkTableCell"

- (instancetype)initNewWorkWithCellModel:(MADayDetail *)model indexPath:(NSIndexPath *)indexPath {
    self = [super init];
    if (self) {
        
        self.newWorkModelView.dayDetail = model;
        preIndexPath = indexPath;
        
    }
    
    return self;
}


- (MANewWorkViewModel *)newWorkModelView {
    if (!_newWorkModelView) {
        _newWorkModelView = [[MANewWorkViewModel alloc] init];
    }
    
    return _newWorkModelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationBarBtn];
    
    self.newWorkModelView.modelTableView = self.workTableView;
    
    if (!self.newWorkModelView.dayDetail) {
        self.newWorkModelView.dayDetail = [MADayDetail new];
        
        [self.newWorkModelView modelConverArrayAndRefreshTableView];
    } else {
        [self.newWorkModelView requestToServerGetTaskData];
    }
    
    [self.newWorkModelView registerForKeyboardNotifications];
}

- (MADurationView *)durationView {
    if (!_durationView) {
        _durationView = [[MADurationView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _durationView.delegate = self;
        
        [self.view addSubview:_durationView];
    }
    
    return _durationView;
}

- (void)navigationBarBtn {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.nm_size = CGSizeMake(70, 30);
    [button addTarget:self action:@selector(sureItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)sureItem {
    downKeyBoard();
    NSString *result = [self.newWorkModelView checkDayWorkDetail];
    if (!isNewEmpty(result)) {
        return [self alertViewWithMessage:result];
    }
    
    [self submitRequest];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    NSDictionary *dict = self.newWorkModelView.dataSource[section];
    
    return dict[@"name"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.newWorkModelView.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newWorkModelView numberOfRowAtInSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MAWorkOptionTableViewCell *cell = [self.newWorkModelView dequeueDayDetailTableViewCell:indexPath];
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section ==0 && indexPath.row == 0) {
        MAProjectListViewController *listView = [[MAProjectListViewController alloc] init];
        listView.delegate = self;
        [self.navigationController pushViewController:listView animated:YES];
    } else if (indexPath.section==0 && indexPath.row == 1) {
        
        if (isNewEmpty(self.newWorkModelView.dayDetail.projectId))
            return alertMBProgressHUDToView(@"请先选择项目组", self.view);
        
        MATaskViewController *taskViewController = [MATaskViewController newTaskViewController:self.newWorkModelView.dayDetail.projectId taskArray:self.newWorkModelView.taskArray];
        taskViewController.delegate = self;
        [self.navigationController pushViewController:taskViewController animated:YES];
        
    } else if (indexPath.section==0 && indexPath.row == 2) {
        
        [self.durationView showPickerView];
        [self.view addSubview:self.durationView];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.newWorkModelView enableEditRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.newWorkModelView deleteRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    downKeyBoard();
}

- (void)submitRequest {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(replaceWorkContent:indexPath:)]) {
        [self.delegate replaceWorkContent:self.newWorkModelView.dayDetail indexPath:preIndexPath];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertViewWithMessage:(NSString *)msg {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:alertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)addWorkContent:(NSString *)val withIndexPath:(NSIndexPath *)indexPath {
    
    [self.newWorkModelView replaceContent:val editRowAtIndexPath:indexPath];
}

- (void)touchProjectName:(MAProjectModel *)projectModel {
    
    [self.newWorkModelView changeProjectName:projectModel];
}

- (void)touchTask:(MATaskModel *)taskModel {
    
    [self.newWorkModelView changeTasktName:taskModel];
}

- (void)selectPickerRow:(NSString *)duration {
    [self.newWorkModelView chanageDuration:duration];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
