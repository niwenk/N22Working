//
//  MAInstance.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResponse.h"
@interface MAInstance : NSObject

+ (instancetype)getInstance;

- (BOOL)isLogin;

- (void)setCacheInfo:(LoginResponse *)response;

- (LoginResponse *)getLoginCacheInfo;

- (MAUser *)getUser;

- (MAStaff *)getStaff;

- (NSString *)getSessionId;

@end
