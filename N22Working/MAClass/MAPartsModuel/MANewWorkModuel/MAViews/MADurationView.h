//
//  MADurationView.h
//  N22Working
//
//  Created by nwk on 2017/4/11.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MADurationDelegate <NSObject>

- (void)selectPickerRow:(NSString *)duration;

@end

@interface MADurationView : UIView

@property (assign, nonatomic) id<MADurationDelegate> delegate;

-(void)showPickerView;

@end
