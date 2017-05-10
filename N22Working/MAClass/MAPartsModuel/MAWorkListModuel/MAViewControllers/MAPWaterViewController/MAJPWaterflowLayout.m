//
//  MAJPWaterflowLayout.m
//  N22Working
//
//  Created by nwk on 2017/3/31.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAJPWaterflowLayout.h"

#define JPCollectionW self.collectionView.frame.size.width

/** 每一行之间的间距 */
static const CGFloat JPDefaultRowMargin = 10;
/** 每一列之间的间距 */
static const CGFloat JPDefaultColumnMargin = 10;
/** 每一列之间的间距 top, left, bottom, right */
static const UIEdgeInsets JPDefaultInsets = {10, 10, 10, 10};
/** 默认的列数 */
static const int JPDefaultColumsCount = 2;

@interface MAJPWaterflowLayout()
/** 每一列的最大Y值 */
@property (nonatomic, strong) NSMutableArray *columnMaxYs;
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation MAJPWaterflowLayout

#pragma mark - 懒加载
- (NSMutableArray *)columnMaxYs
{
    if (!_columnMaxYs) {
        _columnMaxYs = [[NSMutableArray alloc] init];
    }
    return _columnMaxYs;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

#pragma mark - 实现内部的方法
/**
 * 决定了collectionView的contentSize
 */
- (CGSize)collectionViewContentSize
{
    // 找出最长那一列的最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最大值
        if (destMaxY < columnMaxY) {
            destMaxY = columnMaxY;
        }
    }
    return CGSizeMake(0, destMaxY + JPDefaultInsets.bottom);
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 重置每一列的最大Y值
    [self.columnMaxYs removeAllObjects];
    for (NSUInteger i = 0; i<JPDefaultColumsCount; i++) {
        [self.columnMaxYs addObject:@(JPDefaultInsets.top)];
    }
    
    // 计算所有cell的布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 说明所有元素（比如cell、补充控件、装饰控件）的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 说明cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /** 计算indexPath位置cell的布局属性 */
    NSArray *months = @[@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
    // 水平方向上的总间距
    CGFloat xMargin = JPDefaultInsets.left + JPDefaultInsets.right + (JPDefaultColumsCount - 1) * JPDefaultColumnMargin;
    // cell的宽度
    CGFloat w = (JPCollectionW - xMargin) / JPDefaultColumsCount;
    // cell的高度，测试数据，随机数
//    CGFloat h = 50 + arc4random_uniform(150);
    CGFloat h = 50 + arc4random()%150;
    
    // 找出最短那一列的 列号 和 最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (NSUInteger i = 1; i<self.columnMaxYs.count; i++) {
        // 取出第i列的最大Y值
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        // 找出数组中的最小值
        if (destMaxY > columnMaxY) {
            destMaxY = columnMaxY;
            destColumn = i;
        }
    }
    
    // cell的x值
    CGFloat x = JPDefaultInsets.left + destColumn * (w + JPDefaultColumnMargin);
    // cell的y值
    CGFloat y = destMaxY + JPDefaultRowMargin;
    // cell的frame
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新数组中的最大Y值
    self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

@end
