//
//  MAClock.h
//  N22Working
//
//  Created by nwk on 2017/4/7.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MACodeTable : NSObject

+ (instancetype)getInstance;

- (NSString *)getProjectNameWithId:(NSString *)projectId;

- (NSArray *)getProjectList;

@end
