//
//  MAWorkOptionTableViewCell.h
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAProjectModel.h"

@protocol MAWorkOptionDelegate <NSObject>

- (void)addWorkContent:(NSString *)val withIndexPath:(NSIndexPath *)indexPath;

@end

@interface MAWorkOptionTableViewCell : UITableViewCell

@property (assign, nonatomic) id<MAWorkOptionDelegate> delegate;

- (void)cellModelWithIndexPath:(NSIndexPath *)indexPath cellModel:(NSDictionary *)cellModel;

@end
