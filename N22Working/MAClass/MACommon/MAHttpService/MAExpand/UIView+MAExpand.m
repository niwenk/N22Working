//
//  UIView+MAExpand.m
//  IosProject
//
//  Created by nwk on 2016/10/30.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "UIView+MAExpand.h"

@implementation UIView (MAExpand)

//获取程序第一个view
+(UIView *)firstViewForProject{
    
    UIViewController *viewController = [self firstControllerForProject];
    if (viewController) {
        return viewController.view;
    }
    return nil;
}
//获取程序第一个viewController
+ (UIViewController *)firstControllerForProject{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        NSArray *array = [(UINavigationController *)viewController viewControllers];
        for (UIViewController *vc in array) {
            if ([vc isKindOfClass:NSClassFromString(@"ZLPMainViewController")]) {
                return vc;
            }
        }
    }
    return nil;
}
//获取程序第一个view的frame
+(CGRect)firstViewFrameForProject{
    return [self firstViewForProject].frame;
}
@end
