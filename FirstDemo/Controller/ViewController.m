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
    
//    if(![[Fmdbtool GetInstance]serchBySql:@"select * from t_student where id = '1'"])
//    {
//        NSLog(@"error");
//    }
//    if(![[Fmdbtool GetInstance]ExecSQL:@"insert into t_student (name,age) values ('asd',100)"])
//    {
//        NSLog(@"error");
//    }
    NSLog(@"%@",[[Fmdbtool GetInstance]serchBySql:@"select * from t_student"]);
//    if([[Fmdbtool GetInstance]ExecSQL:@"delete from t_student where id = 7 "])
//    {
//        NSLog(@"nihao");
//    }
//    NSLog(@"%@",);
}






@end


