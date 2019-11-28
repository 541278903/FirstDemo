//
//  ToastViewController.m
//  FirstDemo
//
//  Created by edward on 2019/11/28.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "ToastViewController.h"
#import <Masonry/Masonry.h>
#import "Toast.h"

@interface ToastViewController ()

@property(nonatomic,strong)UIButton *loadingbtn;
@property(nonatomic,strong)UIButton *loadingwithmassage;

@end

@implementation ToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.view setBackgroundColor:UIColor.whiteColor];
    [self AddAllCon];
}
-(void)AddAllCon{
    [self.view addSubview:self.loadingbtn];
    [self.loadingbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(100);
        make.height.offset(50);
    }];
    [self.view addSubview:self.loadingwithmassage];
    [self.loadingwithmassage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.loadingbtn);
        make.top.equalTo(self.loadingbtn.mas_bottom).offset(10);
    }];
}
#pragma mark - 首次初始化
- (UIButton *)loadingbtn
{
    if(!_loadingbtn){
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = UIColor.blueColor;
        [btn setTitle:@"Loadingbtn" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(locadingtest) forControlEvents:UIControlEventTouchUpInside];
        _loadingbtn = btn;
    }
    return _loadingbtn;
}
- (UIButton *)loadingwithmassage
{
    if(!_loadingwithmassage){
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = UIColor.blueColor;
        [btn setTitle:@"LoadingWithMessage" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loadingwithmessage) forControlEvents:UIControlEventTouchUpInside];
        _loadingwithmassage = btn;
    }
    return _loadingwithmassage;
}
-(void)loadingwithmessage{
    NSLog(@"message");
}
-(void)locadingtest{
    [[Toast GetInstance]showMessage];
}
@end
