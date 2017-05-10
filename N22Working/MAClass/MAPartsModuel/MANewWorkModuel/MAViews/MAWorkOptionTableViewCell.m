//
//  MAWorkOptionTableViewCell.m
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MAWorkOptionTableViewCell.h"
#import "MANewWorkViewController.h"
#import "MATools.h"

@interface MAWorkOptionTableViewCell ()<UITextFieldDelegate>
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

@implementation MAWorkOptionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    
    return self;
}

- (void)initUI {
    CGRect rect = [UIScreen mainScreen].bounds;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    CGFloat x = CGRectGetWidth(rect) - CGRectGetWidth(self.frame)+60;
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, CGRectGetWidth(rect)-x, CGRectGetHeight(self.frame))];
    self.detailLabel.font = [UIFont systemFontOfSize:16];
    self.detailLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.detailLabel];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(rect)-20, CGRectGetHeight(self.frame))];
    self.textField.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.textField];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"work_add"] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(0, 0, 50, 32);
    [addBtn addTarget:self action:@selector(addBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    self.textField.rightView = addBtn;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    self.textField.delegate = self;
    
}

- (void)cellModelWithIndexPath:(NSIndexPath *)indexPath cellModel:(NSDictionary *)model {
    self.indexPath = indexPath;
    NSArray *values = model[@"values"];
    
    if (indexPath.section == 0) {
        self.nameLabel.hidden = NO;
        self.detailLabel.hidden = NO;
        
        self.textField.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSDictionary *dict = values[indexPath.row];
        switch (indexPath.row) {
            case 0:
            case 1:
                self.nameLabel.text = dict[@"name"];
                self.detailLabel.text = dict[@"value"];
                break;
            case 2:
                self.nameLabel.text = dict[@"name"];
                if (!isNewEmpty(dict[@"value"])) {
                    self.detailLabel.text = [NSString stringWithFormat:@"%@小时",dict[@"value"]];
                } else {
                    self.detailLabel.text = @"";
                }
                
                break;
            default:
                break;
        }
    } else {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        
        self.nameLabel.hidden = YES;
        self.detailLabel.hidden = YES;
        self.textField.hidden = NO;
        
        if (indexPath.row < values.count) {
            NSDictionary *dict = values[indexPath.row];
            NSString *content = dict[@"value"];
            self.textField.text = content;
            self.textField.rightViewMode = UITextFieldViewModeNever;
        } else {
            self.textField.text = @"";
            self.textField.rightViewMode = UITextFieldViewModeAlways;
        }
    }
}

- (void)addBtnPressed {
    
    [self.textField resignFirstResponder];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addWorkContent:withIndexPath:)]) {
        [self.delegate addWorkContent:self.textField.text withIndexPath:self.indexPath];
    }
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
