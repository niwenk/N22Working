//
//  MANewsTableViewCell.h
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MANewsModel.h"

@protocol MANewsTableViewCellDelegate <NSObject>

- (void)reloadCellAtIndexPathWithUrl:(NSString *)url;

@end

@interface MANewsTableViewCell : UITableViewCell

@property (assign, nonatomic) id<MANewsTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIImageView *conImg;
@property (weak, nonatomic) IBOutlet UILabel *authNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;

- (void)cellValue:(MANewsModel *)news indexPath:(NSIndexPath *)indexPath;

@end
