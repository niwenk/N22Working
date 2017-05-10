//
//  MAPCollectionView.m
//  N22Working
//
//  Created by nwk on 2017/3/31.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAPCollectionView.h"

@interface MAPCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *collectionArray;

@end

@implementation MAPCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return self;
}

- (void)setCollectionArray:(NSArray *)dataArray {
    _collectionArray = dataArray;
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
@end
