//
//  MANewsCollectionViewCell.m
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsCollectionViewCell.h"
#import "MANewsContentTableView.h"

@interface MANewsCollectionViewCell()

@property (weak, nonatomic) MANewsContentTableView *newsTableView;

@end

@implementation MANewsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNewsContentView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setupNewsContentView {
    
    MANewsContentTableView *tableView = [[MANewsContentTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self addSubview:tableView];
    self.newsTableView = tableView;
    
}


- (void)visibleAreaEdgeInsets:(UIEdgeInsets)edgeInsets {
    self.newsTableView.contentInset = edgeInsets;
    self.newsTableView.scrollIndicatorInsets = edgeInsets;
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
    self.newsTableView.property = self.delegate;
}

- (void)setTypeDic:(NSDictionary *)typeDic {
    _typeDic = typeDic;
    NSString *type = _typeDic[@"key"];
    self.newsTableView.type = type;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
