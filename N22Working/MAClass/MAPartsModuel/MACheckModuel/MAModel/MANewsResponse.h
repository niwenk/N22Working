//
//  MANewsResponse.h
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MANewsResponse : NSObject

@property (strong, nonatomic) NSString *stat;
@property (strong, nonatomic) NSMutableArray *data;

@end

@interface MANewsBaseModel : NSObject

@property (strong, nonatomic) NSString *reason;
@property (strong, nonatomic) MANewsResponse *result;

@end
