//
//  ViewController.m
//  FirstDemo
//
//  Created by Edward on 2019/9/9.
//  Copyright © 2019 com.Edward. All rights reserved.
//


#import "ViewController.h"
#import "PageView.h"
#import "Fmdbtool.h"
#import "NetAsk.h"

#define myurl @"http://y2k8lcqgv7.52http.net/TServer.asmx/GetAllData"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载bundle资源
    self.view.backgroundColor = UIColor.whiteColor;
    NSString *Toast = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:Toast];
    NSLog(@"%@",dic);
}



@end


