//
//  MATaskViewController.m
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MATaskViewController.h"
#import <MJExtension.h>
#import "MAFNetworkingTool.h"
#import "MABaseModel.h"
#import "MATaskModel.h"
#import "MATaskTableViewCell.h"

@interface MATaskViewController ()
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation MATaskViewController

+ (instancetype)newTaskViewController:(NSString *)projectId taskArray:(NSMutableArray *)taskArray {
    MATaskViewController *taskViewController = [[MATaskViewController alloc] init];
    if (taskArray && taskArray.count) {
        [taskViewController manageDataSource:taskArray];
    } else {
        [taskViewController getTaskCodeTable:projectId];
    }
    return taskViewController;
}

- (void)getTaskCodeTable:(NSString *)projectId {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"projectId"] = projectId;
    dic[@"projectType"] = @0;
    
    NSString *jsonStr = [dic mj_JSONString];
    
    [MAFNetworkingTool POST:HttpTagTaskList parameters:@{@"opt":jsonStr} successBlock:^(id responesObj) {
        
        NSLog(@"----%@",[responesObj mj_JSONString]);
        
        [MABaseModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"MATaskModel"};
        }];
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        if (response.success) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:response.data];
            
            [self manageDataSource:array];
            
            [self.taskTableView reloadData];
        }
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)manageDataSource:(NSMutableArray *)array {
    for (MATaskModel *model in array) {
        [self manageChildDataSource:model.childs parentId:model.tid];
    }
    
    self.dataSource = array;
}

- (void)manageChildDataSource:(NSMutableArray *)array parentId:(NSString *)parentId {
    for (MATaskModel *model in array) {
        model.parentId = parentId;
        
        if (model.childs && model.childs.count) {
            [self manageChildDataSource:model.childs parentId:model.tid];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.taskTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.taskTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"task_bg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#define MATaskTableCell @"MATaskTableViewCell"
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MATaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MATaskTableCell];
    if (!cell) {
        cell = [[MATaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MATaskTableCell];
    }
    MATaskModel *taskModel = self.dataSource[indexPath.row];
    [cell refreshTaskName:taskModel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MATaskModel *taskModel = self.dataSource[indexPath.row];
    
    if (taskModel.childs.count<1) {
        NSLog(@"....%@",taskModel.name);
        if (self.delegate && [self.delegate respondsToSelector:@selector(touchTask:)]) {
            [self.delegate touchTask:taskModel];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    if (taskModel.isOpen) {
        [self closeTableViewCell:taskModel index:indexPath.row+1];
    }else{
        NSInteger index = [_dataSource indexOfObject:taskModel];
        [self openTableViewCell:taskModel index:index+1];
    }
}
#define Bg_Color [UIColor colorWithRed:59/255.0 green:239/255.0 blue:210/255.0 alpha:1.0]

///打开
-(void)openTableViewCell:(MATaskModel *)fatherNode index:(NSInteger)index
{
    if (fatherNode)
    {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *cellIndexPaths = [NSMutableArray array];
        
        NSUInteger count = index;
        for(MATaskModel *node in fatherNode.childs) {
            node.taskLevel = fatherNode.taskLevel + 1;
            node.taskColor = Bg_Color;
            [array addObject:node];
            [cellIndexPaths addObject:[NSIndexPath indexPathForRow:count++ inSection:0]];
        }
        
        if (array.count) {
            fatherNode.isOpen = YES;
            
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index,[array count])];
            [_dataSource insertObjects:array atIndexes:indexes];
        }
        
        [self.taskTableView insertRowsAtIndexPaths:cellIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index-1 inSection:0];
    MATaskTableViewCell *cell = (MATaskTableViewCell *)[self.taskTableView cellForRowAtIndexPath:path];
    [cell refreshTaskName:fatherNode];
}
///关闭
-(void)closeTableViewCell:(MATaskModel *)fatherNode index:(NSInteger)index
{
    if (fatherNode) {
        
        NSMutableArray *cellIndexPaths = [NSMutableArray array];
        
        [self recursive:fatherNode.childs tempArray:cellIndexPaths count:index];
        
        [self recursive:fatherNode.childs];
        
        fatherNode.isOpen = NO;
        
        [self.taskTableView deleteRowsAtIndexPaths:cellIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index-1 inSection:0];
    MATaskTableViewCell *cell = (MATaskTableViewCell *)[self.taskTableView cellForRowAtIndexPath:path];
    [cell refreshTaskName:fatherNode];
}
-(void)recursive:(NSMutableArray *)menus tempArray:(NSMutableArray *)array count:(NSInteger)count
{
    for (MATaskModel *task in menus) {
        NSInteger index = count + array.count;
        [array addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        if (task.isOpen) {
            [self recursive:task.childs tempArray:array count:count];
        }
    }
}

-(void)recursive:(NSMutableArray *)menus
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:menus];
    for (MATaskModel *task in array) {
        if (task.isOpen && task.childs.count) {
            task.isOpen = NO;
            task.taskColor = [UIColor clearColor];
            [self recursive:task.childs];
        }
        [_dataSource removeObject:task];
    }
}
@end
