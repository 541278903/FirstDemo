//
//  YKAlertView.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/8/21.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YKAlertView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "UIDevice+YYK.h"

#define IS_IPHONE_X [UIDevice isIPhoneXSeries]
@interface YKAlertView()

@property(nonatomic,weak) UIViewController *viewController;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,assign) AlertShowType showType;

@end

@implementation YKAlertView

- (instancetype)initViewController:(UIViewController *)viewController  showType:(AlertShowType)showType
{
    self = [super init];
    if (self) {
        [self setup];
        self.viewController = viewController;
        self.showType = showType;
        self.bgView.clipsToBounds = YES;
        @weakify(self);
        UISwipeGestureRecognizer *swip;
        if(self.showType == AlertShowTypeFromTop)
        {

            swip = [[UISwipeGestureRecognizer alloc]init];
            swip.direction = UISwipeGestureRecognizerDirectionUp;
        }else if (self.showType == AlertShowTypeFromBottom)
        {

            swip = [[UISwipeGestureRecognizer alloc]init];
            swip.direction = UISwipeGestureRecognizerDirectionDown;
        }else{

            swip = [[UISwipeGestureRecognizer alloc]init];
            swip.direction = UISwipeGestureRecognizerDirectionLeft;
        }
        [[swip rac_gestureSignal]subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            [self dissView];
        }];
        [self.mainView addGestureRecognizer:swip];
    }
    return self;
}
-(void)setup{
    
}
-(void)tap:(UISwipeGestureRecognizer *)swip
{
    CGFloat cgx;
    CGFloat cgy;
    if(self.showType == AlertShowTypeFromBottom)
    {
        cgx = 15;
        cgy = UIScreen.mainScreen.bounds.size.height;
    }else if (self.showType == AlertShowTypeFromTop)
    {
        cgx = 15;
        cgy = 0 - UIScreen.mainScreen.bounds.size.height;
    }else
    {
        cgy = IS_IPHONE_X ? 54 :30;
        cgx = 0 - UIScreen.mainScreen.bounds.size.width;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.mainView.frame = CGRectMake(cgx,
                                            cgy,
                                            CGRectGetWidth(self.mainView.frame),
                                            CGRectGetHeight(self.mainView.frame));
    } completion:^(BOOL finished) {

        if(finished)
        {
            [self.bgView removeFromSuperview];

        }
    }];
}
-(void)showView{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    UIViewController *vc = window.rootViewController;
    while(vc.presentedViewController){
      vc=vc.presentedViewController;
    }
    [vc.view addSubview:self.bgView];
    CGFloat x;
    CGFloat y;
    if (self.showType == AlertShowTypeFromBottom) {
        x = 15;
        y = UIScreen.mainScreen.bounds.size.height - CGRectGetHeight(self.mainView.frame) - (IS_IPHONE_X ? 34 : 15);
        
    }else if (self.showType == AlertShowTypeFromTop){
        x = 15;
        y = IS_IPHONE_X ? 54 :30;
    }else if(self.showType == AlertShowTypeFromLeft)
    {
        x = 0;
        y = IS_IPHONE_X ? 54 :30;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.mainView.frame = CGRectMake(x,
                                            y,
                                            CGRectGetWidth(self.mainView.frame),
                                            CGRectGetHeight(self.mainView.frame));
    }];
    
}
-(void)dissView{
    CGFloat cgx;
    CGFloat cgy;
    if(self.showType == AlertShowTypeFromBottom)
    {
        cgx = 15;
        cgy = UIScreen.mainScreen.bounds.size.height;
    }else if (self.showType == AlertShowTypeFromTop)
    {
        cgx = 15;
        cgy = 0 - UIScreen.mainScreen.bounds.size.height;
    }else
    {
        cgy = IS_IPHONE_X ? 54 :30;
        cgx = 0 - UIScreen.mainScreen.bounds.size.width;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.mainView.frame = CGRectMake(cgx,
                                            cgy,
                                            CGRectGetWidth(self.mainView.frame),
                                            CGRectGetHeight(self.mainView.frame));
    } completion:^(BOOL finished) {

        if(finished)
        {
            [self.bgView removeFromSuperview];

        }
    }];

}
- (void)addViewinMainView:(UIView *)view
{
    [self.mainView addSubview:view];
    if(self.showType == AlertShowTypeFromBottom)
    {
        [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-(IS_IPHONE_X ? 34 :15));
            make.left.mas_equalTo(self.bgView.mas_left).offset(15);
            make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        }];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
//            make.height.mas_equalTo(200);
            make.right.bottom.mas_equalTo(-10);
        }];
    }else if(self.showType == AlertShowTypeFromTop)
    {
        [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_top).offset(IS_IPHONE_X ? 54 :30);
            make.left.mas_equalTo(self.bgView.mas_left).offset(15);
            make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        }];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
//            make.height.mas_equalTo(200);
            make.right.bottom.mas_equalTo(-10);
        }];
    }else
    {
        [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_top).offset(IS_IPHONE_X ? 54 :30);
            make.left.mas_equalTo(self.bgView.mas_left).offset(0);
            make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-(IS_IPHONE_X ? 34 :15));
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.width.mas_equalTo(200);
            make.right.bottom.mas_equalTo(-10);
        }];
    }
    [self layoutSubviews];
}


#pragma mark -get/set
- (UIView *)bgView
{
    if(!_bgView)
    {
        CGFloat screenW = UIScreen.mainScreen.bounds.size.width;
        CGFloat screenH = UIScreen.mainScreen.bounds.size.height;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
        CGFloat cgx;
        CGFloat cgy;
        if(self.showType == AlertShowTypeFromBottom)
        {
            cgx = 15;
            cgy = screenH;
        }else if (self.showType == AlertShowTypeFromTop)
        {
            cgx = 15;
            cgy = 0 - screenH;
        }else
        {
            cgy = IS_IPHONE_X ? 54 :30;
            cgx = 0 - screenW;
        }

        view.backgroundColor = UIColor.grayColor;
        view.alpha = 0.8;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        @weakify(self);
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            [UIView animateWithDuration:0.1 animations:^{
                self.mainView.frame = CGRectMake(cgx,
                                                    cgy,
                                                    CGRectGetWidth(self.mainView.frame),
                                                    CGRectGetHeight(self.mainView.frame));
            } completion:^(BOOL finished) {

                if(finished)
                {
                    [view removeFromSuperview];

                }
            }];
        }];
        view.gestureRecognizers = nil;
        [view addGestureRecognizer:tap];
        [view addSubview:self.mainView];
        
        
        _bgView = view;
    }
    return _bgView;
}
//
- (UIView *)mainView
{
    if(!_mainView)
    {
        
        CGFloat screenW = UIScreen.mainScreen.bounds.size.width;
        CGFloat screenH = UIScreen.mainScreen.bounds.size.height;
        CGFloat x;
        CGFloat y;
        CGFloat w;
        CGFloat h;
        if(self.showType == AlertShowTypeFromBottom)
        {
            x = 15;
            y = screenH;
            w = screenW-30;
            h = 100;
        }else if (self.showType == AlertShowTypeFromTop)
        {
            x = 15;
            y = 0 - screenH;
            w = screenW-30;
            h = 100;
        }else
        {
            y = IS_IPHONE_X ? 54 :30;
            x = 0 - screenW;
            w = 300;
            h = screenH-(IS_IPHONE_X ? 54 :30);
        }
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        view.backgroundColor = UIColor.whiteColor;
        view.userInteractionEnabled = YES;
        view.layer.cornerRadius = self.showType == AlertShowTypeFromLeft?0: 8;
        view.alpha = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        }];
        view.gestureRecognizers = nil;
        [view addGestureRecognizer:tap];
        
        _mainView = view;
    }
    return _mainView;
}

@end
