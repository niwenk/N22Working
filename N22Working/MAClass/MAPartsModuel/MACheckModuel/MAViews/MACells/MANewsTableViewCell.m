//
//  MANewsTableViewCell.m
//  N22Working
//
//  Created by nwk on 2017/4/27.
//  Copyright © 2017年 com.sh.n22. All rights reserved.
//

#import "MANewsTableViewCell.h"
#import <Masonry.h>
#import <SDImageCache.h>
#import <UIImageView+WebCache.h>

@interface MANewsTableViewCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSString *imageUrl;

@end

@implementation MANewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

static CGFloat const margin = 10;

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 *margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}


- (void)cellValue:(MANewsModel *)news indexPath:(NSIndexPath *)indexPath {
    self.titlelabel.text = news.title;
    self.authNamelabel.text = news.author_name;
    self.datelabel.text = news.date;
    
    NSMutableArray *images = [NSMutableArray array];
    news.thumbnail_pic_s ? [images addObject:news.thumbnail_pic_s] : nil;
    news.thumbnail_pic_s02 ? [images addObject:news.thumbnail_pic_s02] : nil;
    news.thumbnail_pic_s03 ? [images addObject:news.thumbnail_pic_s03] : nil;
    
    [self showNewView:images :news];
}

- (void)showNewView:(NSMutableArray *)images :(MANewsModel *)news {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat width = news.imgFrame.size.width;
    
    if (images.count) {
        
        for (int i=0; i<images.count; i++) {
            NSString *imgUrl = images[i];
            UIImageView *imageView = [[UIImageView alloc] init];
            [self setImageURLSize:imgUrl imageView:imageView w:width];
           
            imageView.frame = CGRectMake(10*(i+1)+i*width, news.imgFrame.origin.y, width , news.imgFrame.size.height);
            
            [self addSubview:imageView];
            
        }
    }
}

-(CGSize)setImageURLSize:(NSString*)imageURL imageView:(UIImageView *)imageView w:(CGFloat)width
{
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: imageURL];
    
    // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了，除了高度不固定的文字部分。
    if (!image) {
        image = [UIImage imageNamed:@"img1"];
        //  图片不存在，下载图片
        [self setImageUrl:imageURL];
    } else  {
        imageView.image = image;
    }
    
    return image.size;
}

-(void) setImageUrl:(NSString *)imageUrl{
    if (imageUrl) {
        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
        // 没有缓存图片
        if (!cachedImage) {
            // 利用 SDWebImage 框架提供的功能下载图片
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                // 保存图片
                [[SDImageCache sharedImageCache] storeImage:image forKey:imageUrl toDisk:YES completion:nil]; // 保存到磁盘
                if ([self.delegate respondsToSelector:@selector(reloadCellAtIndexPathWithUrl:)]) {
                    [self.delegate reloadCellAtIndexPathWithUrl:imageUrl];
                }
            }];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    
    self.autoresizingMask = UIViewAutoresizingNone;//去掉自动布局
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image)
        
    {
        
        newimage = nil;
        
    } else {
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height)
            
        {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        } else {
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}

@end
