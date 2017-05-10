//
//  MADayDetailTableViewCell.m
//  N22Working
//
//  Created by nwk on 2017/4/7.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MADayDetailTableViewCell.h"
#import "MACodeTable.h"
#import <Masonry.h>

@interface MADayDetailTableViewCell()

@property (strong, nonatomic) UILabel *proLabel;
@property (strong, nonatomic) UILabel *durationLabel;
@property (strong, nonatomic) UITextView *contentTextView;
@property (strong, nonatomic) UIButton *opinionBtn;
@property (strong, nonatomic) UIButton *updateBtn;
@property (weak, nonatomic) NSIndexPath *indexPath;

@end

@implementation MADayDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
    }
    
    return self;
}

- (void)initUI {
    
    self.contentView.backgroundColor = [UIColor colorWithRed:81/255.0 green:206/255.0 blue:205/255.0 alpha:1];
    
    self.proLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.proLabel.font = [UIFont systemFontOfSize:17];
    self.proLabel.textAlignment = NSTextAlignmentLeft;
    self.proLabel.text = @"";
    [self addSubview:self.proLabel];
    
    WS(ws);
    [self.proLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left).offset(20);
        make.top.equalTo(ws.mas_top);
        make.right.equalTo(ws.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    self.durationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.durationLabel.font = [UIFont systemFontOfSize:15];
    self.durationLabel.textAlignment = NSTextAlignmentLeft;
    self.durationLabel.text = @"时长：";
    self.durationLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.durationLabel];
    
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left).offset(20);
        make.bottom.equalTo(ws.mas_bottom).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(28);
    }];
    
    self.updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.updateBtn.frame = CGRectZero;
    [self.updateBtn setImage:[UIImage imageNamed:@"update.png"] forState:UIControlStateNormal];
    [self.updateBtn setImage:[UIImage imageNamed:@"update_select.png"] forState:UIControlStateHighlighted];
    [self.updateBtn addTarget:self action:@selector(updateWorking:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.updateBtn];
    
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right).offset(-20);
        make.bottom.equalTo(ws.mas_bottom).offset(-10);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    
    
    self.opinionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.opinionBtn.frame = CGRectZero;
    [self.opinionBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [self.opinionBtn setImage:[UIImage imageNamed:@"check_select.png"] forState:UIControlStateHighlighted];
    [self.opinionBtn addTarget:self action:@selector(opinionWorking:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.opinionBtn];
    
    [self.opinionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.updateBtn.mas_left).offset(-20);
        make.bottom.equalTo(ws.mas_bottom).offset(-10);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
    
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.contentTextView.font = [UIFont systemFontOfSize:16];
    self.contentTextView.textAlignment = NSTextAlignmentLeft;
    self.contentTextView.text = @"";
    self.contentTextView.backgroundColor = [UIColor clearColor];
    self.contentTextView.textColor = [UIColor whiteColor];
    self.contentTextView.editable = NO;
    [self addSubview:self.contentTextView];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left).offset(20);
        make.top.equalTo(ws.proLabel.mas_bottom);
        make.right.equalTo(ws.mas_right).offset(-20);
        make.bottom.equalTo(ws.opinionBtn.mas_top).offset(-20);
    }];
    
}

- (CGFloat)cellHeight {
    
    CGFloat height = [self.contentTextView sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame)-40, MAXFLOAT)].height;
    
    return height + 40 + 28 + 20 + 10;
}

- (void)cellValue:(MADayDetail *)dayDetail indexPath:(NSIndexPath *)indexPath {
    
    self.indexPath = indexPath;
    NSString *projectName = [[MACodeTable getInstance] getProjectNameWithId:dayDetail.projectId];
    self.proLabel.text = projectName;
    dayDetail.projectName = projectName;
    self.durationLabel.text = [NSString stringWithFormat:@"时长：%@小时", dayDetail.duration];
    self.contentTextView.text = [self manageContent:dayDetail.content];
}

- (void)updateWorking:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateCurrentDayWorking:)]) {
        [self.delegate updateCurrentDayWorking:self.indexPath];
    }
}

- (void)opinionWorking:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(opinionCurrentDayWorking:)]) {
        [self.delegate opinionCurrentDayWorking:self.indexPath];
    }
}

- (NSString *)manageContent:(NSArray *)contents {
    NSMutableString *appStr = [NSMutableString string];
    for (NSString *content in contents) {
        [appStr appendFormat:@"%@\n",content];
    }
    
    return appStr;
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
