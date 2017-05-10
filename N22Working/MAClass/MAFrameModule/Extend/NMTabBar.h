//
//  NMTabBar.h
//  BirdLOVESheep
//
//  Created by nwk on 16/8/8.
//  Copyright © 2016年 倪文康. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MATabBarDelegate <NSObject>

- (void)addWorking;

@end

@interface NMTabBar : UITabBar

@property (assign, nonatomic) id<MATabBarDelegate> addDelegate;

@end
