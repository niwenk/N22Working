//
//  MAInstance.m
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAInstance.h"

@interface MAInstance()
@property (strong, nonatomic) LoginResponse *response;
@end

@implementation MAInstance

static MAInstance *instance;
+ (instancetype)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MAInstance alloc] init];
    });
    
    return instance;
}

- (BOOL)isLogin {
    if ([self getLoginCacheInfo]) {
        return YES;
    }
    
    return NO;
}

- (void)setCacheInfo:(LoginResponse *)response {
    _response = response;
}

- (LoginResponse *)getLoginCacheInfo {
    return self.response;
}

- (MAUser *)getUser {
    return self.response.user;
}

- (MAStaff *)getStaff {
    return self.response.staff;
}

- (NSString *)getSessionId {
    return self.response.sessionid;
}

@end
