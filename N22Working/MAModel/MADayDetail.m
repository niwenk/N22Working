//
//  MADayDetail.m
//  N22Working
//
//  Created by nwk on 2017/4/7.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MADayDetail.h"
#import <MJExtension.h>

@implementation MADayDetail

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"content":@"NSString"};
}

- (NSString *)contentStr {
    if (!_contentStr || [_contentStr isEqualToString:@""]) {
        _contentStr = [_content mj_JSONString];
    }
    
    return _contentStr;
}

@end
