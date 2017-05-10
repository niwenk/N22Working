//
//  MANewsModel.m
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsModel.h"
#import <SDImageCache.h>

@interface MANewsModel()
{
    CGRect _imgFrame;
}

@end

@implementation MANewsModel

- (CGFloat)cell_h {
    if (!_cell_h) {
        
        CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 4*10;
        
        CGFloat text_h = [self.title boundingRectWithSize:CGSizeMake(cellWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        CGFloat bottomHeight = 44;
        
        NSMutableArray *images = [NSMutableArray array];
        self.thumbnail_pic_s ? [images addObject:self.thumbnail_pic_s] : nil;
        self.thumbnail_pic_s02 ? [images addObject:self.thumbnail_pic_s02] : nil;
        self.thumbnail_pic_s03 ? [images addObject:self.thumbnail_pic_s03] : nil;
        
        CGFloat imgHeight = 0.0;
        
        CGSize winSize=[UIScreen mainScreen].bounds.size;
        
        CGFloat cellW = winSize.width - 4 * 10;
        CGFloat invert = (images.count-1) * 10;
        CGFloat width = (cellW-invert)/images.count;
        
        if (images.count) {
            for (int i=0; i<images.count; i++) {
                NSString *urlStr = images[i];
                CGSize size = [self setImageURLSize:urlStr w:cellWidth];
                //手动计算cell
                CGFloat height = size.height * width / size.width;
                
                if (imgHeight < height) {
                    imgHeight = height;
                }
            }
        }
        
        _imgFrame = CGRectMake(0, text_h + 2*10, width, imgHeight);
        
        _cell_h = 10 + text_h + 10 + imgHeight + 20 +bottomHeight;
    }
    
    return _cell_h;
}

-(CGSize)setImageURLSize:(NSString*)imageURL w:(CGFloat)width
{
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: imageURL];
    
    // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了，除了高度不固定的文字部分。
    if (!image) {
        image = [UIImage imageNamed:@"img1"];
    }
    
    return image.size;
}

@end
