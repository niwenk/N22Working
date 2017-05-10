//
//  MADayDetailTableViewCell.h
//  N22Working
//
//  Created by nwk on 2017/4/7.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADayDetail.h"

@protocol MADayDetailDelegate <NSObject>

- (void)updateCurrentDayWorking:(NSIndexPath *)indexPath;
- (void)opinionCurrentDayWorking:(NSIndexPath *)indexPath;

@end

@interface MADayDetailTableViewCell : UITableViewCell

@property (assign, nonatomic) id<MADayDetailDelegate> delegate;

- (CGFloat)cellHeight;
- (void)cellValue:(MADayDetail *)dayDetail indexPath:(NSIndexPath *)indexPath;

@end
