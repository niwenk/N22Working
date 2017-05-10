//
//  MAProjectListViewController.m
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAProjectListViewController.h"
#import "MACodeTable.h"
#import "KBSortTool.h"

@interface MAProjectListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *projectListView;
@property (strong, nonatomic) NSArray *projectList;
@property (strong, nonatomic) NSMutableDictionary *dataDic;

@end

@implementation MAProjectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSArray *)projectList {
    if (!_projectList) {
        NSArray *list = [[MACodeTable getInstance] getProjectList];
        
        self.dataDic = [KBSortTool sortWithDataArray:list andPropertyName:@"name"];
        
        // 所有 key 组头
        _projectList = [KBSortTool sortFirstStrWithArray:self.dataDic.allKeys];
    }
    
    return _projectList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // 索引定组
    return self.projectList.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *value = [self.dataDic objectForKey:self.projectList[section]];
    // 根据索引取值, 取完返回
    return value.count;
}
#define MAProjectListTableViewCell @"MAProjectListTableViewCell"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MAProjectListTableViewCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MAProjectListTableViewCell];
    }
    
    NSArray *value = [_dataDic objectForKey:self.projectList[indexPath.section]];
    MAProjectModel *model = value[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

#pragma mark 组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.projectList[section];
    
}

#pragma mark 索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.projectList;
    
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return index;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *value = [_dataDic objectForKey:self.projectList[indexPath.section]];
    MAProjectModel *model = value[indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchProjectName:)]) {
        [self.delegate touchProjectName:model];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
