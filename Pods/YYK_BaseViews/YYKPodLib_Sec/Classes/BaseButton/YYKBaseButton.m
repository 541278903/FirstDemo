//
//  YYKBaseButton.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YYKBaseButton.h"
#import "UIResponder+YYK.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface YYKBaseButton()
//typedef void(^setConfigBlock)(YYKBaseButtonConfig*);


@property(nonatomic,strong) UIImage * image;
@property(nonatomic,strong) UILabel * title;
@property(nonatomic,strong) UIButton * fullviewbtn;


@end

@implementation YYKBaseButton

- (instancetype)initWithFrame:(CGRect)frame AndYYKBaseButtonConfig:(YYKBaseButtonConfig *)config
{
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
- (instancetype)initWithFrame:(CGRect)frame AndBtnConfig:(void(^)(YYKBaseButtonConfig * btn))gcc
{
    
    if(frame.size.width <=50 && frame.size.height <=50)
    {
        frame.size.width = frame.size.height = 50;
    }
    self = [super initWithFrame:frame];
    if (self) {
//        self.configblock = gcc;
        YYKBaseButtonConfig *btnconfig = [[YYKBaseButtonConfig alloc]init];
        gcc(btnconfig);
        [self SetupConfig:btnconfig];
    }
    return self;
}

-(void)SetupConfig:(YYKBaseButtonConfig *)config{
    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    self.image = config.image;
    
    self.title = [[UILabel alloc]init];
//    [self.title sizeToFit];
    [self.fullviewbtn setImage:self.image forState:UIControlStateNormal];
//    self.fullviewbtn.yk_imageState(self.image,UIControlStateNormal);
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
    
    
    [self addSubview:self.title];
    [self addSubview:self.fullviewbtn];
    
}
#pragma mark get/set
- (UIButton *)fullviewbtn
{
    if(!_fullviewbtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.bounds;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self routerEventWithName:YKBtnSend userInfo:@{} needBuried:NO];
        }];
        _fullviewbtn = btn;
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
- (YYKLabelType)type
{
    if(!_type)
    {
        _type = YYKBaseButtonTypeLabelBottom;
    }
    return _type;
}
- (NSString *)titleName
{
    if(!_titleName)
    {
        _titleName = @"按钮";
    }
    return _titleName;
}
- (UIImage *)image
{
    if(!_image)
    {
        _image = [UIImage imageNamed:@""];
    }
    return _image;
}


@end
