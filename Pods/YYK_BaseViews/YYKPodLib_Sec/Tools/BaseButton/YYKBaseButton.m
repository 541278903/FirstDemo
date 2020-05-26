//
//  YYKBaseButton.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YYKBaseButton.h"
@interface YYKBaseButton()

//@property(nonatomic,strong) UIImageView * imageView;
@property(nonatomic,strong) UIImage * image;
@property(nonatomic,strong) UILabel * title;
@property(nonatomic,strong) UIButton * fullviewbtn;

@end

@implementation YYKBaseButton

- (instancetype)initWithFrame:(CGRect)frame AndYYKBaseButtonConfig:(YYKBaseButtonConfig *)config
{
    CGRect m = frame;
    if(frame.size.width <=50 && frame.size.height <=50)
    {
        frame.size.width = frame.size.height = 50;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        [self SetupConfig:config];
    }
    return self;
}

-(void)SetupConfig:(YYKBaseButtonConfig *)config{
    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    self.image = config.image;
//    self.title.text = config.titleName;
    if(config.selfViewController)
    {
        [self.fullviewbtn addTarget:config.selfViewController action:config.target forControlEvents:UIControlEventTouchUpInside];
    }
    self.title = [[UILabel alloc]init];
//    [self.title sizeToFit];
    [self.fullviewbtn setImage:self.image forState:UIControlStateNormal];
    CGRect labelrect;
    CGRect btnrect;
    UIFont *font;
    if (config.type == YYKBaseButtonTypeLabelBottom) {
        //标题在底部
        btnrect = CGRectMake(x, y, w, h*4/5);
        labelrect = CGRectMake(x, h*4/5, w, h/5);
    }else if (config.type == YYKBaseButtonTypeLabelTop){
        labelrect = CGRectMake(x, y, w, h/5);
        btnrect = CGRectMake(x, h/5, w, h*4/5);
    }else if (config.type == YYKBaseButtonTypeOnlyImage){
        btnrect = CGRectMake(x, y, w, h);
        labelrect = CGRectMake(0, 0, 0, 0);
    }else if(config.type == YYKBaseButtonTypeOnlyTilte)
    {
        btnrect = CGRectMake(x, y, w, h);
        labelrect = CGRectMake(0, 0, 0, 0);
        [self.fullviewbtn setTitle:config.titleName forState:UIControlStateNormal];
        [self.fullviewbtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        self.fullviewbtn.layer.borderWidth = 1.0;
        self.fullviewbtn.layer.borderColor = UIColor.blackColor.CGColor;
        [self.fullviewbtn setImage:nil forState:UIControlStateNormal];
        
    }
    self.title.frame = labelrect;
    self.fullviewbtn.frame = btnrect;
    
    self.title.textAlignment = NSTextAlignmentCenter;
//    [self.title sizeToFit];
    if(w>= 50)
    {
        font = [UIFont systemFontOfSize:w/6];
    }
    
    self.title.text = config.titleName;
    self.title.font = config.font;
    self.title.font = font;
    
//    self.fullviewbtn.backgroundColor = UIColor.redColor;
//    self.title.backgroundColor = UIColor.yellowColor;
    
    [self addSubview:self.title];
    [self addSubview:self.fullviewbtn];
    
}
#pragma mark get/set
- (UIButton *)fullviewbtn
{
    if(!_fullviewbtn){
        _fullviewbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullviewbtn.frame = self.bounds;
    }
    return _fullviewbtn;
}



@end
@implementation YYKBaseButtonConfig
//- (YYKLabelType)type
//{
//    if(!_type)
//    {
//        _type = YYKBaseButtonTypeLabelBottom;
//    }
//    return _type;
//}


@end
