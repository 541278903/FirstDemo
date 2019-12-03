//
//  ToastViewController.m
//  FirstDemo
//
//  Created by edward on 2019/11/28.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "ToastViewController.h"
#import "PrefixHeader.pch"

@interface ToastViewController ()

@property(nonatomic,strong)UIButton *loadingbtn;
@property(nonatomic,strong)UIButton *loadingwithmassage;
@property(nonatomic,strong)UIButton *loadingwithcancel;

@end

@implementation ToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.view setBackgroundColor:UIColor.whiteColor];
    [self AddAllCon];
}
#pragma mark - 添加控件
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
    [self.view addSubview:self.loadingwithcancel];
    [self.loadingwithcancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.loadingbtn);
        make.top.equalTo(self.loadingwithmassage.mas_bottom).offset(10);
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
- (UIButton *)loadingwithcancel{
    if(!_loadingwithcancel){
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = UIColor.blueColor;
        [btn setTitle:@"LoadingWithCancle" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loadingcancel:) forControlEvents:UIControlEventTouchUpInside];
        _loadingwithcancel = btn;
    }
    return _loadingwithcancel;
}
-(void)loadingcancel:(id)sender{
    [[Toast GetInstance]annularDeterminatecancelation];
}
-(void)loadingwithmessage{
//    NSLog(@"message");
    [[Toast GetInstance]annularDeterminate];
}
-(void)locadingtest{
    [[Toast GetInstance]nomalToast];
}
//-(void)
@end
