//
//  ViewController.m
//  FirstDemo
//
//  Created by Edward on 2019/9/9.
//  Copyright © 2019 com.Edward. All rights reserved.
//


#import "ViewController.h"
#import "PageView.h"
#import "TButton.h"
#import "Fmdbtool.h"
#import "MoveRedView.h"
#import "RecognizerView.h"

@interface ViewController ()

@property(nonatomic,strong)RecognizerView *recview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.recview = [[RecognizerView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.recview setBackgroundColor:UIColor.redColor];
    [self.view addSubview:self.recview];
    
    
    
}


//平移手势
-(void)moveRe
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pansct:)];
    
    [self.recview addGestureRecognizer:pan];
}
-(void)pansct:(UIPanGestureRecognizer *)pan
{
    CGPoint tranp = [pan translationInView:self.recview];
    self.recview.transform = CGAffineTransformTranslate(self.recview.transform, tranp.x, tranp.y);
    [pan setTranslation:CGPointZero inView:self.recview];
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
//    NSLog(@"$@");
}






@end


