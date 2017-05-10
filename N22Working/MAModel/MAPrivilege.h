//
//  MAPrivilege.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//  特权

#import <Foundation/Foundation.h>

@interface MAPrivilege : NSObject
@property (assign, nonatomic) int status;
@property (assign, nonatomic) int sort;
@property (strong, nonatomic) NSString *icon;
@property (assign, nonatomic) long updateTime;
@property (strong, nonatomic) NSArray *childPrivileges;
@property (strong, nonatomic) NSString *mark;
@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *name;

@end
