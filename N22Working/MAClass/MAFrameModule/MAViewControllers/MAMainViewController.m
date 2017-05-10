//
//  MAHomeViewController.m
//  N22Working
//
//  Created by nwk on 2017/3/31.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAMainViewController.h"
#import "NMTabBar.h"
#import "NMNavigationController.h"
#import "UIView+Extension.h"
#import "MAHomeViewController.h"
#import "MAMeViewController.h"
#import "MADayViewController.h"
#import "MATools.h"
#import "MAInstance.h"
#import "LoginViewController.h"
#import "MANewsViewController.h"
#import "MABookWorldViewController.h"

@interface MAMainViewController ()<MATabBarDelegate>

@end

@implementation MAMainViewController

+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NMTabBar *tabBar = [[NMTabBar alloc] init];
    tabBar.addDelegate = self;
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    [self setupChildViewControllers];
    
}

-(void)setupChildViewControllers{
    
    [self setupChildViewController:[[MAHomeViewController alloc] init] title:@"工时列表" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    [self setupChildViewController:[[MANewsViewController alloc] init] title:@"精选新闻" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    [self setupChildViewController:[[MABookWorldViewController alloc] init] title:@"书中世界" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildViewController:[[MAMeViewController alloc] init] title:@"未完待续" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
    MADayViewController *dayController = [MADayViewController newDayViewController:[NSDate date]];
    dayController.title = dateFormatter([NSDate date], @"yyyy-MM-dd");
    [self addChildViewController:[[NMNavigationController alloc] initWithRootViewController:dayController]];
    
}
-(void)setupChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    
    vc.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [self addChildViewController:[[NMNavigationController alloc] initWithRootViewController:vc]];
}

- (void)addWorking {
    
    self.selectedIndex = self.viewControllers.count-1;
}

@end
