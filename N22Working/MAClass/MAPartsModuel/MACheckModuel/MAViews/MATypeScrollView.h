//
//  MATypeScrollView.h
//  N22Working
//
//  Created by nwk on 2017/4/26.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MATypeScrollDelegate <NSObject>

- (void)touchTypeWithScrollView:(NSInteger)index;

@end

@interface MATypeScrollView : UIScrollView

@property (readonly, nonatomic) NSArray *types;
@property (assign, nonatomic) id<MATypeScrollDelegate> typeDelegate;

- (void)updatelineFrameWithIndex:(NSInteger)index;

@end
