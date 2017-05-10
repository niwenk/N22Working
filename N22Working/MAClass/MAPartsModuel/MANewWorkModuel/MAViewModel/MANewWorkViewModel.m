//
//  MANewWorkViewModel.m
//  N22Working
//
//  Created by nwk on 2017/4/13.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewWorkViewModel.h"
#import "MATools.h"
#import "MAFNetworkingTool.h"
#import <MJExtension.h>
#import "MABaseModel.h"

#define MANewWorkTableCell @"MANewWorkTableCell"

@implementation MANewWorkViewModel

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (void)requestToServerGetTaskData {
    if (isNewEmpty(self.dayDetail.projectId)) {
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"projectId"] = self.dayDetail.projectId;
    dic[@"projectType"] = @0;
    
    NSString *jsonStr = [dic mj_JSONString];
    
    [MAFNetworkingTool POST:HttpTagTaskList parameters:@{@"opt":jsonStr} successBlock:^(id responesObj) {
        
        NSLog(@"----%@",[responesObj mj_JSONString]);
        
        [MABaseModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"MATaskModel"};
        }];
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        if (response.success) {
            self.taskArray = response.data;
            if (!isNewEmpty(self.dayDetail.type)) {
                NSString *taskName = [self chooseTaskItem:self.taskArray :self.dayDetail.type];
                
                self.dayDetail.taskName = taskName;
                
                NSLog(@"---%@",taskName);
            }
            
            
            [self modelConverArrayAndRefreshTableView];
        }
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (MAWorkOptionTableViewCell *)dequeueDayDetailTableViewCell:(NSIndexPath *)indexPath {
    MAWorkOptionTableViewCell *cell = [self.modelTableView dequeueReusableCellWithIdentifier:MANewWorkTableCell];
    if (!cell) {
        cell = [[MAWorkOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MANewWorkTableCell];
    }
    NSDictionary *model = self.dataSource[indexPath.section];
    
    [cell cellModelWithIndexPath:indexPath cellModel:model];
    return cell;
}

- (void)modelConverArrayAndRefreshTableView {
    [self.dataSource removeAllObjects];
    
    NSMutableArray *optionArray = [NSMutableArray array];
    [optionArray addObject:@{@"name":@"项目组",@"value":nilWithString(self.dayDetail.projectName)}];
    [optionArray addObject:@{@"name":@"任务",@"value":nilWithString(self.dayDetail.taskName)}];
    [optionArray addObject:@{@"name":@"时长",@"value":nilWithString(self.dayDetail.duration)}];
    
    [self.dataSource addObject:@{@"name":@"工时选项:",@"values":optionArray}];
    
    NSMutableArray *detailArray = [NSMutableArray array];
    
    if (!self.dayDetail.content || !self.dayDetail.content) {
        self.dayDetail.content = [NSMutableArray array];
    }
    
    for (NSString *string in self.dayDetail.content) {
        [detailArray addObject:@{@"name":@"content",@"value":string}];
    }
    
    [self.dataSource addObject:@{@"name":@"工时说明:",@"values":detailArray}];
    
    [self.modelTableView reloadData];
}

- (BOOL)enableEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *model = self.dataSource[indexPath.section];
    NSArray *values = model[@"values"];
    if (indexPath.row < values.count) {
        NSDictionary *dict = values[indexPath.row];
        
        if (isEqualToString(dict[@"name"], @"content") &&
            !isNewEmpty(dict[@"value"])) {
            return YES;
        }
    }
    return NO;
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *model = self.dataSource[indexPath.section];
    NSMutableArray *values = model[@"values"];
    NSDictionary *dict = values[indexPath.row];
    [values removeObject:dict];
    [self.dayDetail.content removeObject:dict[@"value"]];
    
    [self.modelTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSString *)checkDayWorkDetail {
    if (isNewEmpty(self.dayDetail.projectId)) {
        return @"请选择项目组";
    } else if (isNewEmpty(self.dayDetail.type)) {
        return @"请选择任务";
    } else if (isNewEmpty(self.dayDetail.duration)) {
        return @"请选择时长";
    } else {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dayDetail.content];
        
        if (!tempArray.count) {
            return @"请填写工时说明";
        }
    }
    
    return nil;
}

- (void)replaceContent:(NSString *)content editRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isNewEmpty(content)) return;
    if (indexPath.row < self.dayDetail.content.count) {
        [self.dayDetail.content replaceObjectAtIndex:indexPath.row withObject:content];
    } else {
        [self.dayDetail.content addObject:content];
    }
    
    [self modelConverArrayAndRefreshTableView];
}

- (void)changeProjectName:(MAProjectModel *)project {
    if (![self.dayDetail.projectId isEqualToString:project.tid]) {
        self.dayDetail.type = nil;
        self.dayDetail.taskName = nil;
        [self.taskArray removeAllObjects];
    }
    
    self.dayDetail.projectId = project.tid;
    self.dayDetail.projectName = project.name;
    [self modelConverArrayAndRefreshTableView];
}

- (void)changeTasktName:(MATaskModel *)task {
    self.dayDetail.type = task.tid;
    self.dayDetail.taskName = task.name;
    [self modelConverArrayAndRefreshTableView];
}

- (void)chanageDuration:(NSString *)duration {
    self.dayDetail.duration = duration;
    [self modelConverArrayAndRefreshTableView];
}

- (NSString *)chooseTaskItem:(NSMutableArray *)tasks :(NSString *)taskId {
    for (MATaskModel *task in tasks) {
        if (isEqualToString(task.tid, taskId)) {
            return task.name;
        } else if(task.childs && task.childs.count){
            NSString *name = [self chooseTaskItem:task.childs :taskId];
            if (name) {
                return name;
            }
        }
    }
    return nil;
}
- (NSInteger)numberOfRowAtInSection:(NSInteger)section {
    NSDictionary *dict = self.dataSource[section];
    NSArray *array = dict[@"values"];
    if ([dict[@"name"] isEqualToString:@"工时说明:"]) {
        return array.count+1;
    }
    return array.count;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    
}

@end
