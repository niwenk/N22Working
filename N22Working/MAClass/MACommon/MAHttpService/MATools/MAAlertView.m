//
//  MAAlertView.m
//  IosProject
//
//  Created by nwk on 2016/11/3.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "MAAlertView.h"

@implementation MAAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles complete:(UpdateCompleteBlock)complete {
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    self.block = complete;
    
    return self;
}


-(void)show{
    [super show];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAlertView) name:@"HideAlertView" object:nil];
}

- (void)hideAlertView{
    [self dismissWithClickedButtonIndex:0 animated:NO];
}

-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
