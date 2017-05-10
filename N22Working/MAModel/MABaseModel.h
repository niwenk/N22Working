//
//  MABaseModel.h
//  N22Working
//
//  Created by nwk on 2017/3/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MABaseModel : NSObject

@property (assign, nonatomic) BOOL success;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSMutableArray *data;

@end
