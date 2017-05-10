//
//  UIView+Extension.m
//  BirdLOVESheep
//
//  Created by nwk on 16/8/8.
//  Copyright © 2016年 倪文康. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void)setNm_x:(CGFloat)nm_x{
    CGRect frame = self.frame;
    frame.origin.x = nm_x;
    self.frame = frame;
}
-(void)setNm_y:(CGFloat)nm_y{
    CGRect frame = self.frame;
    frame.origin.y = nm_y;
    self.frame = frame;
}
-(void)setNm_width:(CGFloat)nm_width{
    CGRect frame = self.frame;
    frame.size.width = nm_width;
    self.frame = frame;
}
-(void)setNm_height:(CGFloat)nm_height{
    CGRect frame = self.frame;
    frame.size.height = nm_height;
    self.frame = frame;
}

-(void)setNm_size:(CGSize)nm_size{
    CGRect frame = self.frame;
    frame.size = nm_size;
    self.frame = frame;
}
-(void)setNm_point:(CGPoint)nm_point{
    CGRect frame = self.frame;
    frame.origin = nm_point;
    self.frame = frame;
}
-(CGFloat)nm_x{
    return self.frame.origin.x;
}
-(CGFloat)nm_y{
    return self.frame.origin.y;
}
-(CGFloat)nm_width{
    return self.frame.size.width;
}
-(CGFloat)nm_height{
    return self.frame.size.height;
}
-(CGSize)nm_size{
    return self.frame.size;
}
-(CGPoint)nm_point{
    return self.frame.origin;
}
@end
