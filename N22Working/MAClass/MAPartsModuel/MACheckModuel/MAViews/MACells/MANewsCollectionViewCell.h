//
//  MANewsCollectionViewCell.h
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MANewsCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSDictionary *typeDic;
@property (assign, nonatomic) id delegate;

- (void)visibleAreaEdgeInsets:(UIEdgeInsets)edgeInsets;

@end
