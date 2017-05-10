//
//  MAMeViewController.m
//  N22Working
//
//  Created by nwk on 2017/3/31.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAMeViewController.h"

@interface MAMeViewController ()

@end

@implementation MAMeViewController
#define MeTableViewCell @"MAMeTableViewCell"
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeTableViewCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"批量插入本月工时";
    return cell;
}
@end
