//
//  LoginResponse.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAStaff.h"
#import "MAUser.h"

@interface LoginResponse : NSObject

@property (strong, nonatomic) MAStaff *staff;
@property (strong, nonatomic) NSString *sessionid;
@property (strong, nonatomic) NSArray *roles;
@property (assign, nonatomic) BOOL is_admin;
@property (strong, nonatomic) NSArray *leaderProjects;
@property (strong, nonatomic) MAUser *user;

@end
