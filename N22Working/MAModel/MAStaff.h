//
//  MAStaff.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAStaff : NSObject

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *mobile;
@property (assign, nonatomic) int status;
@property (assign, nonatomic) long updateTime;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *positionId;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *name;

@end
