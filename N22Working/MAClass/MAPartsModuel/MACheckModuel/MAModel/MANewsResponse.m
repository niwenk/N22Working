//
//  MANewsResponse.m
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsResponse.h"
#import <MJExtension.h>

@implementation MANewsResponse

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":@"MANewsModel"};
}

@end

@implementation MANewsBaseModel

@end
