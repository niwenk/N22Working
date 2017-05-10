//
//  MATaskViewController.h
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MATaskModel.h"
@protocol MATaskDelegate <NSObject>

- (void)touchTask:(MATaskModel *)taskModel;

@end

@interface MATaskViewController : UIViewController

@property (assign, nonatomic) id<MATaskDelegate> delegate;

+ (instancetype)newTaskViewController:(NSString *)projectId taskArray:(NSMutableArray *)taskArray;

@end
