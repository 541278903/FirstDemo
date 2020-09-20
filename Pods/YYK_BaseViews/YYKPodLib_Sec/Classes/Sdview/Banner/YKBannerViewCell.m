//
//  YKBannerViewCell.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/15.


#import "YKBannerViewCell.h"
#import <Masonry/Masonry.h>


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface YKBannerViewCell ()
@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation YKBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.466);
    }];
}
-(void)loadViewModel:(NSString *)imageName indexPath:(NSIndexPath *)indexPath
{
    //TODO:加载图片
    self.imageView.image = [UIImage imageNamed:imageName];
}
- (UIImageView *)imageView
{
    if(!_imageView)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
        _imageView = imageView;
    }
    return _imageView;
}
@end
