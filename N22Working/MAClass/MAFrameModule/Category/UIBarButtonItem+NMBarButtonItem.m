//
//  UIBarButtonItem+NMBarButtonItem.m
//  BirdLOVESheep
//
//  Created by nwk on 16/8/8.
//  Copyright © 2016年 倪文康. All rights reserved.
//

#import "UIBarButtonItem+NMBarButtonItem.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (NMBarButtonItem)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.nm_size = button.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
