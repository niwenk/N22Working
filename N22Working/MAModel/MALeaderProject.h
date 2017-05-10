//
//  MALeaderProject.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//  管理项目类

#import <Foundation/Foundation.h>

@interface MALeaderProject : NSObject

@property (assign, nonatomic) int status;
@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) long updateTime;

@end
