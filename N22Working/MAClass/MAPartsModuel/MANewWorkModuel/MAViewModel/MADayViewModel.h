//
//  MADayViewModel.h
//  N22Working
//
//  Created by nwk on 2017/4/13.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MADayDetailTableViewCell.h"

@interface MADayViewModel : NSObject

@property (weak, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) UITableView *dayTableView;
@property (strong, nonatomic) NSMutableArray *dayArray;

/**
 请求服务器获取工时数据

 @param date 某一天 yyyy-MM-dd
 */
- (void)requestToServerGetWorkingData:(NSDate *)date;

/**
 获取cell

 @param indexPath 索引信息
 @return cell
 */
- (MADayDetailTableViewCell *)dequeueDayDetailTableViewCell:(NSIndexPath *)indexPath;

/**
 转换对应的model

 @param indexPath 索引信息
 @return model
 */
- (MADayDetail *)convertDayDetailModel:(NSIndexPath *)indexPath;

/**
 替换工时项，有则替换，无则添加

 @param indexPath 索引信息
 @param dayDetail 工时model
 */
- (void)relpaceDayDetailWorking:(MADayDetail *)dayDetail indexPath:(NSIndexPath *)indexPath;

/**
 准备请求的json字符串

 @return 请求参数
 */
- (NSString *)prepareRequestModel;

/**
 工时提交请求

 @param jsonStr 参数
 */
- (void)requestToServerAddWorking:(NSString *)jsonStr;
@end
