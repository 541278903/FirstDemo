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

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSArray *a = @[@{@"key":@"id",@"value":@"1"}];
    
//    [[Fmdbtool GetInstance]insertWithTable:@"t_student" argmes:a];
//    [[Fmdbtool GetInstance]serchTable:@"t_student" argmes:a];
}






@end


