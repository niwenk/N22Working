//
//  MATaskTableViewCell.m
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MATaskTableViewCell.h"

@implementation MATaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self inittaskViewCell];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)inittaskViewCell
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    taskCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(self.frame))];
    taskCell.backgroundColor = [UIColor clearColor];
    [self addSubview:taskCell];
    
    taskNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(taskCell.frame) - 50, CGRectGetHeight(taskCell.frame))];
    taskNameLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(taskCell.frame) * 0.4];
    taskNameLabel.backgroundColor = [UIColor clearColor];
    taskNameLabel.textColor = [UIColor blackColor];
    taskNameLabel.textAlignment = NSTextAlignmentLeft;
    [taskCell addSubview:taskNameLabel];
    
    
    arrowImag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_arrow_left"]];
    arrowImag.frame = CGRectMake(CGRectGetWidth(rect)-32, (CGRectGetHeight(self.frame)-14)/2, 22, 14);
    [self addSubview:arrowImag];
    
}
-(void)refreshTaskName:(MATaskModel *)task
{
    [self resettaskCellWithFrame:task.taskLevel];
    
    taskNameLabel.text = task.name;
    taskNameLabel.font = [UIFont systemFontOfSize:20-(task.taskLevel+1)];
    
    taskNameLabel.textColor = [UIColor blackColor];
    
    if (task.childs.count>0) {
        arrowImag.hidden = NO;
        
        if (task.isOpen) {
            arrowImag.image = [UIImage imageNamed:@"task_arrow_up"];
        }else{
            arrowImag.image = [UIImage imageNamed:@"task_arrow_down"];
        }
        
    } else {
        arrowImag.hidden = YES;
    }
}
-(void)resettaskCellWithFrame:(int)level
{
    CGRect rect = taskCell.frame;
    rect.origin.x = level * 10;
    rect.size.width = CGRectGetWidth(self.frame) - rect.origin.x;
    taskCell.frame = rect;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
