//
//  YKButton.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YKButton.h"
#import <Masonry/Masonry.h>

typedef void(^DoThing)(void);
@interface YKButton()

@property(nonatomic,strong) UIImage * image;
@property(nonatomic,strong) UILabel * title;
@property(nonatomic,strong) UIButton * fullviewbtn;
@property(nonatomic,strong) YKButtonConfig *btnconfig;
@property(nonatomic,copy) DoThing doThing;


@end

@implementation YKButton

//frame布局
+(instancetype)buttonWithFrame:(CGRect)frame btnConfig:(void(^ __nonnull)(YKButtonConfig * config))configblock btnClickTodo:(void(^ __nonnull)(void))doThing
{
    return [[YKButton alloc]initWithFrame:frame btnConfig:configblock btnClickTodo:doThing];
}

//masory 布局
+(instancetype)buttonWithbtnConfig:(void(^ __nonnull)(YKButtonConfig * config))configblock btnClickTodo:(void(^ __nonnull)(void))doThing
{
    return [[YKButton alloc]initWithbtnConfig:configblock btnClickTodo:doThing];
}

- (instancetype)initWithFrame:(CGRect)frame btnConfig:(void(^ __nonnull)(YKButtonConfig * config))configblock btnClickTodo:(void(^ __nonnull)(void))doThing
{
    
    if(frame.size.width <=50 && frame.size.height <=50)
    {
        frame.size.width = frame.size.height = 50;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.doThing = doThing;
        if(configblock)
        {
            configblock(self.btnconfig);
        }
        [self SetupConfigFrame:self.btnconfig];
    }
    return self;
}
- (instancetype)initWithbtnConfig:(void(^ __nonnull)(YKButtonConfig * config))configblock btnClickTodo:(void(^ __nonnull)(void))doThing
{
    self = [super init];
    if (self) {
        self.doThing = doThing;
        if(configblock)
        {
            configblock(self.btnconfig);
        }
        [self setupConfigMasory:self.btnconfig];
    }
    return self;
}
#pragma mark masory布局
-(void)setupConfigMasory:(YKButtonConfig *)config{

    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.text = config.titleName;
    if (config.font) {
        self.title.font = config.font;
    }
//    self.title.font = [UIFont systemFontOfSize:12];
//    [self.title sizeToFit];
    self.title.adjustsFontSizeToFitWidth = YES;
    
    
    self.image = config.image;
    [self.fullviewbtn setImage:self.image forState:UIControlStateNormal];
    [self.fullviewbtn.imageView setContentMode:UIViewContentModeScaleToFill];
    
    
    [self addSubview:self.title];
    [self addSubview:self.fullviewbtn];
    if (config.type == YKLabelTypeLabelBottom) {
        //标题在底部
        [self addSubview:self.title];
        [self addSubview:self.fullviewbtn];
        [self.fullviewbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(self).multipliedBy(0.8);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.fullviewbtn.mas_bottom).offset(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    else if (config.type == YKLabelTypeLabelTop){

        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(self).multipliedBy(0.2);
        }];
        [self.fullviewbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.title.mas_bottom).offset(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_offset(0);
        }];
    }else if (config.type == YKLabelTypeOnlyImage){
        [self.title removeFromSuperview];
        [self.fullviewbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }else if (config.type == YKLabelTypeOnlyTilte)
    {
        [self.title removeFromSuperview];
        [self.fullviewbtn setTitle:config.titleName forState:UIControlStateNormal];
        [self.fullviewbtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];

        self.fullviewbtn.layer.borderWidth = 1.0;
        self.fullviewbtn.layer.borderColor = UIColor.blackColor.CGColor;
        [self.fullviewbtn setImage:nil forState:UIControlStateNormal];
        
        [self.fullviewbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];

    }
}
#pragma mark frame布局
-(void)SetupConfigFrame:(YKButtonConfig *)config{
    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    self.image = config.image;
    
    [self.fullviewbtn setImage:self.image forState:UIControlStateNormal];
    
    CGRect labelrect;
    CGRect btnrect;
    UIFont *font;
    if (config.type == YKLabelTypeLabelBottom) {
        //标题在底部
        btnrect = CGRectMake(x, y, w, h*4/5);
        labelrect = CGRectMake(x, h*4/5, w, h/5);
    }else if (config.type == YKLabelTypeLabelTop){
        labelrect = CGRectMake(x, y, w, h/5);
        btnrect = CGRectMake(x, h/5, w, h*4/5);
    }else if (config.type == YKLabelTypeOnlyImage){
        btnrect = CGRectMake(x, y, w, h);
        labelrect = CGRectMake(0, 0, 0, 0);
    }else if(config.type == YKLabelTypeOnlyTilte)
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
    if(w>= 50)
    {
        font = [UIFont systemFontOfSize:w/6];
    }
    
//    [self.title sizeToFit];
    
    self.title.text = config.titleName;
    self.title.font = config.font;
    self.title.font = font;
    
    
    [self addSubview:self.title];
    [self addSubview:self.fullviewbtn];
    
}
#pragma mark get/set
- (UILabel *)title
{
    if(!_title)
    {
        _title = [[UILabel alloc]init];
    }
    return _title;
}
- (UIButton *)fullviewbtn
{
    if(!_fullviewbtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setAdjustsImageWhenHighlighted:NO];//取消高亮
        [btn.imageView setContentMode:UIViewContentModeScaleToFill];
        [btn addTarget:self action:@selector(selfdothing) forControlEvents:UIControlEventTouchUpInside];
        _fullviewbtn = btn;
    }
    return _fullviewbtn;
}
- (YKButtonConfig *)btnconfig
{
    if(!_btnconfig)
    {
        YKButtonConfig *x = [[YKButtonConfig alloc]init];
        _btnconfig = x;
    }
    return _btnconfig;
}
-(void)selfdothing{
    if(self.doThing)
    {
        self.doThing();
    }
}


@end
@implementation YKButtonConfig
#pragma mark get/set
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
        _image = [[UIImage alloc]init];
    }
    return _image;
}


@end
