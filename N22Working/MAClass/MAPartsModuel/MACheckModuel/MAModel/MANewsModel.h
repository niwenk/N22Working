//
//  MANewsModel.h
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MANewsModel : NSObject

@property (strong, nonatomic) NSString *uniquekey;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *author_name;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *thumbnail_pic_s;
@property (strong, nonatomic) NSString *thumbnail_pic_s02;
@property (strong, nonatomic) NSString *thumbnail_pic_s03;

@property (assign, nonatomic) CGFloat cell_h;
@property (assign, nonatomic) CGRect imgFrame;

@end
