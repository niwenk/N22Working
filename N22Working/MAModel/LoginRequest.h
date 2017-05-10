//
//  LoginModel.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequest : NSObject

//{\"os\":\"iPhone\",\"browser\":\"Safari\",\"username\":\"niwenkang\",\"password\":\"nwk123\"}"

@property (strong, nonatomic) NSString *os;
@property (strong, nonatomic) NSString *browser;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@end
