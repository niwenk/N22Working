//
//  MADayViewModel.m
//  N22Working
//
//  Created by nwk on 2017/4/13.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MADayViewModel.h"
#import "MATools.h"
#import "MAFNetworkingTool.h"
#import <MJExtension.h>
#import "MABaseModel.h"
#import "MADayDetail.h"

#define MAWorkDetailCell @"MAWorkDetailCell"

@interface MADayViewModel()

@end

@implementation MADayViewModel

- (void)requestToServerGetWorkingData:(NSDate *)date {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"item_time"] = dateFormatter(date,@"yyyy-MM-dd");
    
    NSString *jsonStr = [dic mj_JSONString];
    
    loadingForTextToView(@"正在查询", MAWindowView);
    
    [MAFNetworkingTool POST:HttpTagDetailList parameters:@{@"opt":jsonStr} successBlock:^(id responesObj) {
        
        NSLog(@"----%@",[responesObj mj_JSONString]);
        
        [MABaseModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"MADayDetail"};
        }];
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        if (response.success) {
            self.dayArray = response.data;
            [self.dayTableView reloadData];
        }
        closeHUDToView(MAWindowView);
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
        closeHUDToView(MAWindowView);
    }];
}

- (MADayDetailTableViewCell *)dequeueDayDetailTableViewCell:(NSIndexPath *)indexPath {
    MADayDetailTableViewCell *cell = [self.dayTableView dequeueReusableCellWithIdentifier:MAWorkDetailCell];
    if (!cell) {
        cell = [[MADayDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MAWorkDetailCell];
    }
    MADayDetail *detail = self.dayArray[indexPath.row+indexPath.section];
    [cell cellValue:detail indexPath:indexPath];
    
    return cell;
}

- (void)relpaceDayDetailWorking:(MADayDetail *)dayDetail indexPath:(NSIndexPath *)indexPath {
    
    [self prepareContent:dayDetail.content];
    
    dayDetail.contentStr = [dayDetail.content mj_JSONString];
    
    if (indexPath) {
        [self.dayArray replaceObjectAtIndex:indexPath.section withObject:dayDetail];
    } else {
        [self.dayArray addObject:dayDetail];
    }
    
    [self.dayTableView reloadData];
}

- (MADayDetail *)convertDayDetailModel:(NSIndexPath *)indexPath {
    return self.dayArray[indexPath.section];
}

- (NSString *)prepareRequestModel {
    NSMutableArray *dicArray = [NSMutableArray array];
    
    for (MADayDetail *dayDetail in self.dayArray) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"tid"] = nilWithString(dayDetail.tid);
        dic[@"item_id"] = nilWithString(dayDetail.item_id);
        dic[@"projectId"] = dayDetail.projectId;
        dic[@"duration"] = dayDetail.duration;
        dic[@"type"] = dayDetail.type;
        dic[@"item_time"] = dateFormatter(self.currentDate, @"yyyy-MM-dd");
        dic[@"content"] =  dayDetail.contentStr;
        [dicArray addObject:dic];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (void)prepareContent:(NSMutableArray *)array {
    for (int i=0; i<array.count; i++) {
        NSString *string = array[i];
        NSString *flag = [string substringFromIndex:string.length-1];
        if (!isEqualToString(flag, @"%")) {
            NSString *str = [NSString stringWithFormat:@"%@ 100%%",string];
            [array replaceObjectAtIndex:i withObject:str];
        }
    }
}

- (void)requestToServerAddWorking:(NSString *)jsonStr {
    
    loadingForTextToView(@"正在提交...", MAWindowView);
    
    [MAFNetworkingTool POST:HttpTagAddWorking parameters:@{@"opt":jsonStr} successBlock:^(id responesObj) {
        
        NSLog(@"----%@",[responesObj mj_JSONString]);
        
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        if (response.success) {
            
        }
        alertMBProgressHUDToView(response.message, MAWindowView);
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
        closeHUDToView(MAWindowView);
    }];
}

@end
