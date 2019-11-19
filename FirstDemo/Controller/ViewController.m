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

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    MoveRedView *red = [[MoveRedView alloc]initWithFrame:CGRectMake(100, 100, 20, 20)];
    red.backgroundColor = UIColor.redColor;
    
    UIView *yelloview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    yelloview.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:yelloview];
    
    [self.view addSubview:red];
    
}






@end


