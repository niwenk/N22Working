//
//  LoginResponse.m
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"roles":@"MARole",@"leaderProjects":@"MALeaderProject"};
}

@end
