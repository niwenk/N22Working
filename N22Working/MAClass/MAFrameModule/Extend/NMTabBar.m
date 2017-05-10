//
//  NMTabBar.m
//  BirdLOVESheep
//
//  Created by nwk on 16/8/8.
//  Copyright © 2016年 倪文康. All rights reserved.
//

#import "NMTabBar.h"
#import "UIView+Extension.h"

@interface NMTabBar()

@property (weak, nonatomic) UIButton *publishBtn;

@end

@implementation NMTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateNormal];
        button.nm_size = button.currentBackgroundImage.size;
        [button addTarget:self action:@selector(addBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.publishBtn = button;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.nm_width;
    CGFloat height = self.nm_height;
    
    CGFloat btn_w = width / 5;
    
    self.publishBtn.center = CGPointMake(width*0.5, height*0.5);
    
    NSInteger index = 0;
    for (UIControl *control in self.subviews) {
        if (![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class]]) continue;
        
        control.nm_x = index>1 ? (index+1) * btn_w : index * btn_w;
        control.nm_width = btn_w;
        
        index++;
    }
    
}
-(void)addBtnPressed{
    NSLog(@"--%s",__func__);
    if (self.addDelegate && [self.addDelegate respondsToSelector:@selector(addWorking)]) {
        [self.addDelegate addWorking];
    }
    
}
@end
