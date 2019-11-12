//
//  TButton.m
//  FirstDemo
//
//  Created by Edward on 2019/10/8.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "TButton.h"
#import <UIKit/UIKit.h>
@interface TButton()

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)UILabel *tlabel;
@property(nonatomic,strong)UIImage *timview;


@end

@implementation TButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 50, 60);
//        [self setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
//        [self setTitle:@"cc" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.borderColor = UIColor.blackColor.CGColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self setTitle:@"你好" forState:UIControlStateNormal];
    self.titleLabel.frame = CGRectMake(0, 50, 50, 10);
    self.imageView.frame = CGRectMake(0,0,50,50);

//    [self setTimview:self.timview];
//    [self setImage:self.timview forState:UIControlStateNormal];
}
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(self.bounds.origin.x, self.bounds.origin.y+self.bounds.size.width, self.bounds.size.width, self.frame.size.height-self.frame.size.width);
//}
//
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(contentRect.origin.x, contentRect.origin.y, contentRect.size.width, contentRect.size.width);
//}
- (UIImage *)timview
{
    if(!_timview)
    {
        UIImage *im = [UIImage imageNamed:@"1"];
        _timview = im;
    }
    return _timview;
}

@end
