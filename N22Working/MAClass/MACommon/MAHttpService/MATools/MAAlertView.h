//
//  MAAlertView.h
//  IosProject
//
//  Created by nwk on 2016/11/3.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateCompleteBlock)(BOOL result);

@interface MAAlertView : UIAlertView

@property (copy, nonatomic) UpdateCompleteBlock block;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles complete:(UpdateCompleteBlock)complete;

@end
