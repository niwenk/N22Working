//
//  MANewWorkViewController.h
//  N22Working
//
//  Created by nwk on 2017/4/10.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MAProjectModel.h"
#import "MATaskModel.h"
#import "MADayDetail.h"

@protocol MANewWorkDelegate <NSObject>
//新增或更新 replace代替
- (void)replaceWorkContent:(MADayDetail *)dayDetail indexPath:(NSIndexPath *)indexPath;

@end

@interface MACellModel : NSObject

@property (strong, nonatomic) MAProjectModel *projectModel;
@property (strong, nonatomic) MATaskModel *taskModel;
@property (strong, nonatomic) NSString *duration;
@property (strong, nonatomic) NSMutableArray *contents;
@end

@interface MANewWorkViewController : UIViewController
@property (assign, nonatomic) id<MANewWorkDelegate> delegate;

- (instancetype)initNewWorkWithCellModel:(MADayDetail *)model indexPath:(NSIndexPath *)indexPath;
@end
