//
//  MAClock.m
//  N22Working
//
//  Created by nwk on 2017/4/7.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MACodeTable.h"
#import "MJExtension.h"
#import "MATools.h"
#import "MAFNetworkingTool.h"
#import "MABaseModel.h"
#import "MAProjectModel.h"

@interface MACodeTable()

@property (strong, nonatomic) NSArray *projectArray;

@end

@implementation MACodeTable

static MACodeTable *codeTable = nil;

+ (instancetype)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        codeTable = [[MACodeTable alloc] init];
        [codeTable getProjectCodeTable];
    });
    
    return codeTable;
}

- (void)getProjectCodeTable {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"projectType"] = @0;
    
    NSString *jsonStr = [dic mj_JSONString];
    
    [MAFNetworkingTool POST:HttpTagAllProjectList parameters:@{@"opt":jsonStr} successBlock:^(id responesObj) {
        
        NSLog(@"----%@",[responesObj mj_JSONString]);
        
        [MABaseModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"MAProjectModel"};
        }];
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        if (response.success) {
            self.projectArray = response.data;
        }
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getTaskCodeTable:(NSString *)projectId {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"projectId"] = projectId;
    dic[@"projectType"] = @0;
    
    NSString *jsonStr = [dic mj_JSONString];
    
    [MAFNetworkingTool POST:HttpTagTaskList parameters:@{@"opt":jsonStr} successBlock:^(id responesObj) {
        
        NSLog(@"----%@",[responesObj mj_JSONString]);
        
        [MABaseModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"NSDictionary"};
        }];
        MABaseModel *response = [MABaseModel mj_objectWithKeyValues:responesObj];
        if (response.success) {
            self.projectArray = response.data;
        }
        
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSArray *)getProjectList {
    return self.projectArray;
}

- (NSString *)getProjectNameWithId:(NSString *)projectId {
    
//    [self getTaskCodeTable:projectId];
    
    for (MAProjectModel *pro in self.projectArray) {
        if ([pro.tid isEqualToString:projectId]) {
            return pro.name;
        }
    }
    
    return projectId;
}

@end
