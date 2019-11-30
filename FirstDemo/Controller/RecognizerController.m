//
//  RecognizerController.m
//  FirstDemo
//
//  Created by edward on 2019/11/22.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "RecognizerController.h"
#import "PrefixHeader.pch"
@interface RecognizerController ()

@property(nonatomic,strong)UIView *recview;
@property(nonatomic,strong)UIView *greanview;
@end

@implementation RecognizerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.recview = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.recview.text = @"左右滑";
    [self.recview setBackgroundColor:UIColor.redColor];
    [self.view addSubview:self.recview];
    [self swip];
    self.greanview = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
//    self.greanview.text = @"拖动";
    [self.greanview setBackgroundColor:UIColor.greenColor];
    [self.view addSubview:self.greanview];
    [self moveRe];
    
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
        NSLog(@"right");
    }else if (swip.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"left");
    }
}



@end
