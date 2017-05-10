//
//  MANewsContentTableView.h
//  N22Working
//
//  Created by nwk on 2017/4/28.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MANewsContentDelegate <NSObject>


@end

@interface MANewsContentTableView : UITableView

@property (strong, nonatomic) NSString *type;

@property (assign, nonatomic) id property;

@end
