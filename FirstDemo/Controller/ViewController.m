//
//  ViewController.m
//  FirstDemo
//
//  Created by Edward on 2019/9/9.
//  Copyright © 2019 com.Edward. All rights reserved.
//


#import "ViewController.h"
#import "PrefixHeader.pch"

#define myurl @"http://y2k8lcqgv7.52http.net/TServer.asmx/GetAllData"
#define testurl @"localhost:8181/login"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}
//测试网络请求
-(void)testGET{
    [[NetAsk GetInstance]GET:myurl parameters:@{@"nihao":@"c"} isXML:YES resultcom:^(NSDictionary * _Nonnull bl) {
        MLog(@"%@",bl);
    }];
}
//加载bbundle资源
-(void)loadbundle{
    NSString *Toast = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:Toast];
    MLog(@"%@",dic);
}
//点击空白触发手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self testGET];
//    MLog(@"打印了子控件%@",self.view.subviews);
}




@end


