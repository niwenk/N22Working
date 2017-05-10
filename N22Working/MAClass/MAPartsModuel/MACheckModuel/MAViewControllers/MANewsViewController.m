//
//  MANewsViewController.m
//  N22Working
//
//  Created by nwk on 2017/4/26.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsViewController.h"
#import "MATypeScrollView.h"
#import "MANewsCollectionViewCell.h"
#import <Masonry.h>

@interface MANewsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate,MATypeScrollDelegate>

@property (strong, nonatomic) MATypeScrollView *typeScrollView;
@property (strong, nonatomic) UICollectionView *contentCollectionView;

@end

@implementation MANewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
//    self.tabBarController.tabBar.translucent = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    
    [self initScrollView];
}

- (UICollectionView *)contentCollectionView {
    if (_contentCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        layout.minimumLineSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentCollectionView.backgroundColor = [UIColor clearColor];
        _contentCollectionView.pagingEnabled = YES;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.delegate = self;
    }
    return _contentCollectionView;
}

- (MATypeScrollView *)typeScrollView {
    if (!_typeScrollView) {
        _typeScrollView = [[MATypeScrollView alloc] initWithFrame:CGRectZero];
        _typeScrollView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:0.8];
        _typeScrollView.typeDelegate = self;
    }
    
    return _typeScrollView;
}

- (void)initScrollView {
    
    self.contentCollectionView.width = self.view.width;
    self.contentCollectionView.height = self.view.height;
    
    [self.view addSubview:self.contentCollectionView];
    
    self.typeScrollView.width = self.view.width;
    self.typeScrollView.height = 35;
    self.typeScrollView.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    [self.view addSubview:self.typeScrollView];
    
    [self.contentCollectionView registerClass:[MANewsCollectionViewCell class] forCellWithReuseIdentifier:@"MANewsCell"];
}

#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.typeScrollView.types.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MANewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MANewsCell" forIndexPath:indexPath];
    
    [cell visibleAreaEdgeInsets:UIEdgeInsetsMake(CGRectGetMaxY(self.typeScrollView.frame), 0, self.tabBarController.tabBar.height, 0)];
    
    cell.typeDic = self.typeScrollView.types[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.width, collectionView.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    
    NSInteger index = point.x / CGRectGetWidth(scrollView.frame);
    
    [self.typeScrollView updatelineFrameWithIndex:index];
    
}

- (void)touchTypeWithScrollView:(NSInteger)index {
     int x = CGRectGetWidth(self.typeScrollView.frame) *index;
    
    self.contentCollectionView.contentOffset = CGPointMake(x, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
