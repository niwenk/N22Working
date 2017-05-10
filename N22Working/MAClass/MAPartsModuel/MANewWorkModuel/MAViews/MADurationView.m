//
//  MADurationView.m
//  N22Working
//
//  Created by nwk on 2017/4/11.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MADurationView.h"

@interface MADurationView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *contentView;
    UIPickerView *pickerView;
    NSMutableArray *dataSource;
}
@end

@implementation MADurationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupDataSource];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
    [contentView addSubview:navBar];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureBtnPressed)];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(navBar.frame), CGRectGetWidth(self.frame), 210)];
    pickerView.delegate = self;
    [contentView addSubview:pickerView];
    
    NSInteger row = [dataSource indexOfObject:@"8.0"];
    
    [pickerView selectRow:row inComponent:0 animated:YES];
}

- (void)setupDataSource {
    
    dataSource = [NSMutableArray array];
    
    for (float i = 0.5; i<=24.0; i +=0.5) {
        NSString *string = [NSString stringWithFormat:@"%0.1f",i];
        [dataSource addObject:string];
    }

}
- (void)cancelBtnPressed {
    [self hidePickerView];
}

- (void)sureBtnPressed {
    NSInteger row = [pickerView selectedRowInComponent:0];
    NSString *duration = dataSource[row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectPickerRow:)]) {
        [self.delegate selectPickerRow:duration];
    }
    [self hidePickerView];
}

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

-(void)showPickerView
{
    self.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [contentView setFrame:CGRectMake(0, SCREEN_SIZE.height-254, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    } completion:^(BOOL isFinished){
        
    }];
}
-(void)hidePickerView
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        self.backgroundColor = [UIColor clearColor];
        [contentView setFrame:CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    } completion:^(BOOL isFinished){
        self.userInteractionEnabled = NO;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidePickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return dataSource.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *duration = [NSString stringWithFormat:@"%@小时",dataSource[row]];
    return duration;
}

@end
