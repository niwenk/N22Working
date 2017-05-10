//
//  MANewsModel.h
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MANewsTableViewCell.h"

static NSString *MAContentCell = @"MAContentCell";

@interface MANewsViewModel : NSObject

@property (strong, nonatomic) UITableView *newsTableView;
@property (readonly, nonatomic) NSMutableArray *datasource;


/**
 获取网络新闻数据

 @param type 新闻类型
 */
- (void)requestToServerGetNewsData:(NSString *)type;

/**
 获取cell

 @param indexPath 索引
 @return cell
 */
- (MANewsTableViewCell *)dequeueNewsTableViewCell:(NSIndexPath *)indexPath;

@end
