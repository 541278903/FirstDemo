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
#import "NetAsk.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view.backgroundColor ]
    [self.view setBackgroundColor:UIColor.whiteColor];
//    [[NetAsk GetInstance] POST:@"http://localhost:8080/zxzx" parameters:nil resultcom:^(NSString * _Nonnull bl) {
//        NSLog(@"%@",bl);
//    }];
    [[NetAsk GetInstance]POST:@"http://y2k8lcqgv7.52http.net/TServer.asmx/GetAllData" parameters:nil isXML:YES resultcom:^(NSString * _Nonnull bl) {
        NSLog(@"%@",bl);
    }];
}





@end


