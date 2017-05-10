//
//  MADayDetail.h
//  N22Working
//
//  Created by nwk on 2017/4/7.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADayDetail : NSObject

@property (strong, nonatomic) NSString *approval_man;
@property (assign, nonatomic) int approval_status;
@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *item_id;
@property (strong, nonatomic) NSString *item_time;
@property (strong, nonatomic) NSString *projectId;
@property (strong, nonatomic) NSMutableArray *content;
@property (strong, nonatomic) NSString *duration;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *approval_content;
@property (strong, nonatomic) NSString *score;

@property (strong, nonatomic) NSString *projectName;
@property (strong, nonatomic) NSString *taskName;
@property (strong, nonatomic) NSString *contentStr;

@end
