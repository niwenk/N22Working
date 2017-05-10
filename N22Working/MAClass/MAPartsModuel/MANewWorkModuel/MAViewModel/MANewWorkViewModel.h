//
//  MANewWorkViewModel.h
//  N22Working
//
//  Created by nwk on 2017/4/13.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MAWorkOptionTableViewCell.h"
#import "MADayDetail.h"
#import "MATaskModel.h"
#import "MAProjectModel.h"

@interface MANewWorkViewModel : NSObject
{
    NSMutableArray *contents;
}
@property (strong, nonatomic) MADayDetail *dayDetail;
@property (strong, nonatomic) NSMutableArray *taskArray;
@property (strong, nonatomic) UITableView *modelTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;


/**
 从服务器获取任务集合

 */
- (void)requestToServerGetTaskData;
/**
 获取cell
 
 @param indexPath 索引信息
 @return cell
 */
- (MAWorkOptionTableViewCell *)dequeueDayDetailTableViewCell:(NSIndexPath *)indexPath;


/**
 把对象转换成数组，并刷新tableView

 */
- (void)modelConverArrayAndRefreshTableView;
/**
 判断一行是否能编辑

 @param indexPath 索引信息
 @return 是否显示删除按钮
 */
- (BOOL)enableEditRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 删除一行

 @param indexPath 索引信息
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 校验

 @return 是否通过
 */
- (NSString *)checkDayWorkDetail;

/**
 新增或修改content

 @param content 工时说明
 @param indexPath 索引信息
 */
- (void)replaceContent:(NSString *)content editRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 改变项目组

 @param project 项目组对象
 */
- (void)changeProjectName:(MAProjectModel *)project;

/**
 改变任务名

 @param task 任务对象
 */
- (void)changeTasktName:(MATaskModel *)task;

/**
 改变时长

 @param duration 时长
 */
- (void)chanageDuration:(NSString *)duration;

/**
 选择任务名

 @param tasks 一个项目组下的所有任务集合
 @param taskId 任务主键
 @return 任务名
 */
- (NSString *)chooseTaskItem:(NSMutableArray *)tasks :(NSString *)taskId;

/**
 cell个数

 @param section 索引
 @return 个数
 */
- (NSInteger)numberOfRowAtInSection:(NSInteger)section;

/**
 键盘通知
 */
- (void)registerForKeyboardNotifications;
@end
