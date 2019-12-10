//
//  RecognizerController.m
//  FirstDemo
//
//  Created by edward on 2019/11/22.
//  Copyright © 2019 com.Edward. All rights reserved.
//

//#import "RecognizerController.h"
//#import "PrefixHeader.pch"
@interface RecognizerController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *recview;
@property(nonatomic,strong)UIView *greanview;
@property(nonatomic,strong)UIView *orangeview;
@property(nonatomic,strong)UIView *blackview;
@end

@implementation RecognizerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.recview];
    [self swip];
    [self.view addSubview:self.greanview];
    [self moveRe];
    [self.view addSubview:self.orangeview];
    [self Rotation];
    [self.view addSubview:self.blackview];
    [self Scale];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (UIView *)recview{
    if(!_recview){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        UILabel *reclabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        reclabel.text = @"左右滑";
        [view addSubview:reclabel];
        [view setBackgroundColor:UIColor.redColor];
        _recview = view;
    }
    return _recview;
}
- (UIView *)greanview{
    if(!_greanview){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
        UILabel *greenlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        greenlabel.text = @"拖动";
        [view addSubview:greenlabel];
        [view setBackgroundColor:UIColor.greenColor];
        _greanview = view;
    }
    return _greanview;
}
- (UIView *)orangeview{
    if(!_orangeview){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 500, 100, 100)];
        UILabel *orangelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        orangelabel.text = @"旋转";
        [view addSubview:orangelabel];
        [view setBackgroundColor:UIColor.orangeColor];
        _orangeview = view;
    }
    return _orangeview;
}
- (UIView *)blackview{
    if(!_blackview){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 700, 100, 100)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        label.text = @"放大";
        [view addSubview:label];
        [view setBackgroundColor:UIColor.blueColor];
        _blackview = view;
    }
    return _blackview;
}
-(void)Scale{
    UIPinchGestureRecognizer *pan = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(ScaleSelector:)];
    [self.blackview addGestureRecognizer:pan];
}
-(void)ScaleSelector:(UIPinchGestureRecognizer *)pan{
    CGFloat p = pan.scale;
    self.blackview.transform = CGAffineTransformScale(self.blackview.transform, p, p);
    [pan setScale:1];
}
-(void)Rotation{
    UIRotationGestureRecognizer *pan = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(Rotaitionselector:)];
    [self.orangeview addGestureRecognizer:pan];
}
-(void)Rotaitionselector:(UIRotationGestureRecognizer *)pan{
    CGFloat p = pan.rotation;
    self.orangeview.transform = CGAffineTransformRotate(self.orangeview.transform, p);
    [pan setRotation:0];
}

//平移手势
-(void)moveRe
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pansct:)];
    
    [self.greanview addGestureRecognizer:pan];
}
-(void)pansct:(UIPanGestureRecognizer *)pan
{
    CGPoint tranp = [pan translationInView:self.greanview];
    self.greanview.transform = CGAffineTransformTranslate(self.greanview.transform, tranp.x, tranp.y);
    //重新设置拖动的起始点相应为上一次的拖动后的点，即每改变一次均要重置定位，类似的拖动，放大，旋转均要重置拖动后的起始点
    [pan setTranslation:CGPointZero inView:self.greanview];
}
//清扫
-(void)swip
{
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.recview addGestureRecognizer:swipeleft];
    [self.recview addGestureRecognizer:swiperight];
}

-(void)tap:(UISwipeGestureRecognizer *)swip
{
    if (swip.direction == UISwipeGestureRecognizerDirectionRight) {
        MLog(@"right");
    }else if (swip.direction == UISwipeGestureRecognizerDirectionLeft){
        MLog(@"left");
    }
}



@end
