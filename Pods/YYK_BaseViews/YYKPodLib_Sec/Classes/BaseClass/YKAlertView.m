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
    }
    return self;
}
-(void)setup{
    
}

-(void)showView{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    UIViewController *vc = window.rootViewController;
    while(vc.presentedViewController){
      vc=vc.presentedViewController;
    }
    [vc.view addSubview:self.bgView];
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(0,
                                            UIScreen.mainScreen.bounds.size.height - CGRectGetHeight(self.bgView.frame),
                                            CGRectGetWidth(self.bgView.frame),
                                            CGRectGetHeight(self.bgView.frame));
    }];
    
}
-(void)dissView{
    CGFloat changeH;
    CGFloat changeW;
    if(self.showType == AlertShowTypeFromBottom)
    {
        changeH = UIScreen.mainScreen.bounds.size.height;
        changeW = 0;
    }else if (self.showType == AlertShowTypeFromTop)
    {
        changeH = 0 - UIScreen.mainScreen.bounds.size.height;
        changeW = 0;
    }else if (self.showType == AlertShowTypeFromLeft)
    {
        changeH = 0;
        changeW = 0 - UIScreen.mainScreen.bounds.size.width;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.bgView.frame = CGRectMake(changeW,
                                            changeH,
                                            CGRectGetWidth(self.bgView.frame),
                                            CGRectGetHeight(self.bgView.frame));
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
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
    }];
}


#pragma mark -get/set
- (UIView *)bgView
{
    if(!_bgView)
    {
        UIView *view = [[UIView alloc]init];
        CGFloat screenW = UIScreen.mainScreen.bounds.size.width;
        CGFloat screenH = UIScreen.mainScreen.bounds.size.height;
        CGFloat y = screenH;
        CGFloat x = screenW;
        if(self.showType == AlertShowTypeFromTop)
        {
            y = -screenH;
            x = 0;
        }else if (self.showType == AlertShowTypeFromBottom)
        {
            y = screenH;
            x = 0;
        }else if (self.showType == AlertShowTypeFromLeft)
        {
            //TODO:新增右边弹出
            x = -screenW;
            y = 0;
        }
        CGRect frame = CGRectMake(x,y,screenW,screenH);
        view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = UIColor.clearColor;
        if(self.showType == AlertShowTypeFromLeft)
        {
            view.backgroundColor = UIColor.grayColor;
            view.alpha = 0.8;
        }
        @weakify(self);
        CGFloat changeH;
        CGFloat changeW;
        if(self.showType == AlertShowTypeFromBottom)
        {
            changeH = UIScreen.mainScreen.bounds.size.height;
            changeW = 0;
        }else if (self.showType == AlertShowTypeFromTop)
        {
            changeH = 0 - UIScreen.mainScreen.bounds.size.height;
            changeW = 0;
        }else if (self.showType == AlertShowTypeFromLeft)
        {
            changeH = 0;
            changeW = 0 - UIScreen.mainScreen.bounds.size.width;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            [UIView animateWithDuration:0.1 animations:^{
                view.frame = CGRectMake(changeW,
                                                    changeH,
                                                    CGRectGetWidth(view.frame),
                                                    CGRectGetHeight(view.frame));
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
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(self.showType == AlertShowTypeFromTop)
            {
                make.top.mas_equalTo([UIDevice isIPhoneXSeries]?44:25);
            }else if (self.showType == AlertShowTypeFromBottom)
            {
                make.bottom.mas_equalTo([UIDevice isIPhoneXSeries]?-34:-10);
            }
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
//            make.height.mas_equalTo(50);
        }];
        if(self.showType == AlertShowTypeFromLeft)
        {
            [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo([UIDevice isIPhoneXSeries]?44:25);
                make.bottom.mas_equalTo([UIDevice isIPhoneXSeries]?-34:-10);
                make.width.mas_equalTo(view.mas_width).multipliedBy(0.6);
            }];
        }
        
        _bgView = view;
    }
    return _bgView;
}

- (UIView *)mainView
{
    if(!_mainView)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = UIColor.whiteColor;
        view.userInteractionEnabled = YES;
        view.layer.cornerRadius = 8;
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
