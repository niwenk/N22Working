//
//  MATaskTableViewCell.h
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MATaskModel.h"

@interface MATaskTableViewCell : UITableViewCell
{
    UIButton *doneBtn;
    UIImageView *arrowImag;
    UILabel *taskNameLabel;
    UIView *taskCell;
    __weak IBOutlet UIImageView *taskBg;
}
-(void)refreshTaskName:(MATaskModel *)task;
@end
