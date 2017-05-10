//
//  MAUser.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAUser : NSObject

@property (strong, nonatomic) NSString *projectId;
@property (strong, nonatomic) NSString *password;
@property (assign, nonatomic) int state;
@property (assign, nonatomic) long updateTime;
@property (assign, nonatomic) int status;
@property (assign, nonatomic) int isAuth;
@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *name;

@end
