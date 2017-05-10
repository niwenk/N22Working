//
//  UIBarButtonItem+NMBarButtonItem.h
//  BirdLOVESheep
//
//  Created by nwk on 16/8/8.
//  Copyright © 2016年 倪文康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NMBarButtonItem)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;
@end
