//
//  MATypeScrollView.m
//  N22Working
//
//  Created by nwk on 2017/4/26.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MATypeScrollView.h"

@interface MATypeScrollView()
{
    UILabel *lineLabel;
    NSInteger currentIndex;//当前索引
}
@property (readwrite, nonatomic) NSArray *types;
@end

@implementation MATypeScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.types = [NSArray arrayWithObjects:
                 @{@"key" : @"top", @"value" : @"头条"},
                 @{@"key" : @"shehui", @"value" : @"社会"},
                 @{@"key" : @"guonei",@"value" : @"国内"},
                 @{@"key" : @"guoji", @"value" : @"国际"},
                 @{@"key" : @"yule", @"value" : @"娱乐"},
                 @{@"key" : @"tiyu", @"value" : @"体育"},
                 @{@"key" : @"junshi", @"value" : @"军事"},
                 @{@"key" : @"keji", @"value" : @"科技"},
                 @{@"key" : @"caijing", @"value" : @"财经"},
                 @{@"key" : @"shishang", @"value" :@"时尚"},
                 nil];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

//否	类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)

- (void)drawRect:(CGRect)rect {
    
    lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    lineLabel.backgroundColor = [UIColor redColor];
    lineLabel.height = 2;
    lineLabel.y = rect.size.height - lineLabel.height;
    [self addSubview:lineLabel];
    
    CGFloat width = 70;
    int i=0;
    for (NSDictionary *dic in self.types) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width, 0, width, CGRectGetHeight(rect));
        [button setTitle:dic[@"value"] forState:UIControlStateNormal];
        button.tag = i+168;
        [button addTarget:self action:@selector(typeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
        
        if (i==0) {
            button.selected = YES;
            [button.titleLabel sizeToFit];
            lineLabel.width = button.titleLabel.width;
            lineLabel.centerX = button.centerX;
        }
        
        i++;
    }
    
    self.contentSize = CGSizeMake(self.types.count*width, CGRectGetHeight(rect));
}

- (void)typeBtnPressed:(UIButton *)button {
    
    button.selected = !button.selected;
    
    NSInteger index = button.tag-168;
    
    if (index == currentIndex) return;
    
    UIButton *preBtn = [self viewWithTag:currentIndex+168];
    preBtn.selected = !preBtn.selected;
    
    [self updatelineFrame:index];
    
    currentIndex = index;
    
    if (self.typeDelegate && [self.typeDelegate respondsToSelector:@selector(touchTypeWithScrollView:)]) {
        [self.typeDelegate touchTypeWithScrollView:currentIndex];
    }
    
    [self updateScrollViewWithOffset];
}

- (void)updatelineFrame:(NSInteger)index {
    
    if (currentIndex == index) return;
    
    UIButton *button = [self viewWithTag:index+168];
    
    [UIView animateWithDuration:0.25 animations:^{
        lineLabel.width = button.titleLabel.width;
        lineLabel.centerX = button.centerX;
    }];
}

- (void)updatelineFrameWithIndex:(NSInteger)index {
    
    UIButton *btn = [self viewWithTag:index+168];
    btn.selected = !btn.selected;
    
    UIButton *preBtn = [self viewWithTag:currentIndex+168];
    preBtn.selected = !preBtn.selected;
    
    [self updatelineFrame:index];
    
    currentIndex = index;
    
    [self updateScrollViewWithOffset];
    
}

- (void)updateScrollViewWithOffset {
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGPoint point = self.contentOffset;
    UIButton *btn = [self viewWithTag:currentIndex+168];
    
    NSInteger centerIndex = (width/70)/2;//页面中心点的坐标
    
    CGFloat center = centerIndex * 70;//页面中心点的文职
    CGFloat x = self.contentSize.width - width;//scroll 滚动到最底部的可见区域起始点坐标
    
    CGFloat invert = CGRectGetMinX(btn.frame)-center;//scroll 滚动到指定按钮到中心点的偏移量
    
    if (invert > 0 && invert < x) {
        point.x = invert;
    } else if (invert > x) {
        point.x = x;
    } else {
        point.x = 0;
    }
    
    [self setContentOffset:point animated:YES];
}

@end
