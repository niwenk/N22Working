//
//  MAProjectModel.h
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAProjectModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) int status;
@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *updateTime;

@end
