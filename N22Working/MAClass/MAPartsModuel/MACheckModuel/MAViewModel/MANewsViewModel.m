//
//  MANewsModel.m
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsViewModel.h"
#import "MAFNetworkingTool.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "MANewsResponse.h"

#define MANewsAppKey @"c9ee096625babc8f52d721683a153de3"
#define MANewsServerUrl @"http://v.juhe.cn/toutiao/index"

@interface MANewsViewModel()<MANewsTableViewCellDelegate>

@property (readwrite, nonatomic) NSMutableArray *datasource;

@end

@implementation MANewsViewModel

- (void)requestToServerGetNewsData:(NSString *)type {
    
    NSString *url = [NSString stringWithFormat:@"%@?type=%@&key=%@",MANewsServerUrl,type,MANewsAppKey];
    
    [MAFNetworkingTool newsPOST:url parameters:@"123123213" successBlock:^(id responesObj) {
        
        MANewsBaseModel *baseModel = [MANewsBaseModel mj_objectWithKeyValues:responesObj];
        
        if (baseModel.result) {
            self.datasource = baseModel.result.data;
            
            [self.newsTableView reloadData];
            
        } else {
            [self.datasource removeAllObjects];
            NSLog(@"查询失败！");
        }
        
        [self.newsTableView.mj_header endRefreshing];
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        [self.newsTableView.mj_header endRefreshing];
    }];
}

- (MANewsTableViewCell *)dequeueNewsTableViewCell:(NSIndexPath *)indexPath {
    MANewsTableViewCell *cell = [self.newsTableView dequeueReusableCellWithIdentifier:MAContentCell];
    cell.delegate = self;
    MANewsModel *news = self.datasource[indexPath.row];
    [cell cellValue:news indexPath:indexPath];
    
    return cell;
}

- (void)reloadCellAtIndexPathWithUrl:(NSString *)url {
    if (url) {
        for (int i = 0; i< self.datasource.count; i++) {
            //遍历当前数据源中并找到ImageUrl
            MANewsModel *news = self.datasource.count >i ? self.datasource[i] :nil;
            if ([news.thumbnail_pic_s isEqualToString:url] ||
                [news.thumbnail_pic_s02 isEqualToString:url] ||
                [news.thumbnail_pic_s03 isEqualToString:url]) {
                //获取当前可见的Cell NSIndexPaths
                NSArray *paths  = self.newsTableView.indexPathsForVisibleRows;
                //判断回调的NSIndexPath 是否在可见中如果存在则刷新页面
                NSIndexPath *pathLoad = [NSIndexPath indexPathForItem:i inSection:0];
                for (NSIndexPath *path in paths) {
                    if (path && path == pathLoad ) {
                        [self.newsTableView reloadData];
                    }
                }
            }
        }
    }
}

@end
