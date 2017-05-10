//
//  MANewsContentTableView.m
//  N22Working
//
//  Created by nwk on 2017/4/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsContentTableView.h"
#import "MANewsViewModel.h"
#import "MANewsTableViewCell.h"
#import <MJRefresh.h>
#import "MANewsHtmlViewController.h"
#import "MANewsViewController.h"

@interface MANewsContentTableView()<UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (strong, nonatomic) MANewsViewModel *newsViewModel;

@end

@implementation MANewsContentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupNotification];
        
        [self setupTableView];
        
        [self setupNewsViewModel];
        
        [self setupHeaderRefresh];
    }
    
    return self;
}

- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"refreshTableView" object:nil];
}

- (void)refreshTableView {
    [self reloadData];
}

- (void)setupTableView {
    
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self registerNib:[UINib nibWithNibName:@"MANewsTableViewCell" bundle:nil] forCellReuseIdentifier:MAContentCell];
}

- (void)setupNewsViewModel {
    self.newsViewModel.newsTableView = self;
}

- (void)setupHeaderRefresh {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsHeader)];
    self.mj_header.automaticallyChangeAlpha = YES;
}

- (void)setType:(NSString *)type {
    _type = type;
    
    [self.mj_header beginRefreshing];
}

- (void)loadNewsHeader {
    
    [self.newsViewModel requestToServerGetNewsData:self.type];
}

- (MANewsViewModel *)newsViewModel {
    if (!_newsViewModel) {
        _newsViewModel = [[MANewsViewModel alloc] init];
    }
    
    return _newsViewModel;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsViewModel.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MANewsModel *news = self.newsViewModel.datasource[indexPath.row];
    
    return news.cell_h;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.newsViewModel dequeueNewsTableViewCell:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MANewsModel *news = self.newsViewModel.datasource[indexPath.row];
    
    MANewsHtmlViewController *htmlController = [[MANewsHtmlViewController alloc] init];
    htmlController.title = news.author_name;
    htmlController.htmlUrl = news.url;
    if (self.property && [self.property isKindOfClass:[MANewsViewController class]]) {
        MANewsViewController *controller = (MANewsViewController *)self.property;
        
        [controller.navigationController pushViewController:htmlController animated:YES];
    }
}

@end
