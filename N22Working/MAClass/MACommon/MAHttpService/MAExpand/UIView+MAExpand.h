//
//  UIView+MAExpand.h
//  IosProject
//
//  Created by nwk on 2016/10/30.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FirstViewForProject [UIView firstViewForProject]
#define FirstControllerForProject [UIView firstControllerForProject]
#define FIRSTViewFrame [UIView firstViewFrameForProject]

@interface UIView (MAExpand)

//获取程序第一个view
+(UIView *)firstViewForProject;
//获取程序第一个viewController
+ (UIViewController *)firstControllerForProject;
//获取程序第一个view的frame
+(CGRect)firstViewFrameForProject;
@end
