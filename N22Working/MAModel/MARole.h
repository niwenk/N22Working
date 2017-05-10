//
//  MARole.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MARole : NSObject

@property (assign, nonatomic) int status;
@property (assign, nonatomic) long updateTime;
@property (strong, nonatomic) NSString *code;
@property (assign, nonatomic) int isDefault;
@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *name;

@end
