//
//  MATaskModel.h
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MATaskModel : NSObject

@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *parentId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *childs;
@property (assign, nonatomic) BOOL isOpen;
@property (assign, nonatomic) int taskLevel;
@property (strong, nonatomic) UIColor *taskColor;
@end
