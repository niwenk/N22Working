//
//  MAProjectListViewController.h
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAProjectModel.h"

@protocol MAProjectListDelegate <NSObject>

- (void)touchProjectName:(MAProjectModel *)projectModel;

@end

@interface MAProjectListViewController : UIViewController

@property (assign, nonatomic) id<MAProjectListDelegate> delegate;

@end
