//
//  ScrollerController.m
//  FirstDemo
//
//  Created by edward on 2019/12/10.
//  Copyright © 2019 com.Edward. All rights reserved.
//


@interface ScrollerController ()
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)UITextField *serchfield;
@property(nonatomic,strong)UIView *buttonview;

@end

@implementation ScrollerController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self serView];
}
#pragma mark -添加控件，添加约束
-(void)serView{
    [self.view addSubview:self.scrollview];
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TOPNAVHEIGHT);
        make.bottom.offset(-TABBAR_HEIGHT);
        make.left.right.equalTo(self.view);
    }];
    [self.scrollview addSubview:self.serchfield];
    [self.serchfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollview).offset(10);
        make.left.equalTo(self.scrollview).offset(30);
        make.right.equalTo(self.scrollview).offset(-30);
        make.height.offset(30);
    }];
    [self.scrollview addSubview:self.buttonview];
    [self.buttonview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.serchfield);
        make.top.equalTo(self.serchfield.mas_bottom).offset(20);
        make.height.offset(700);
    }];
    
}
#pragma mark -初始化控件
- (UITextField *)serchfield{
    if(!_serchfield){
        UITextField *textfield = [[UITextField alloc]init];
        textfield.layer.borderWidth = 0.5;
        textfield.layer.borderColor = UIColor.blackColor.CGColor;
        textfield.placeholder = @"搜索框";
        _serchfield = textfield;
    }
    return _serchfield;
}
- (UIView *)buttonview{
    if(!_buttonview){
        UIView *view = [[UIView alloc]init];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = UIColor.blackColor.CGColor;
        _buttonview = view;
    }
    return _buttonview;
}
-(UIScrollView *)scrollview{
    if(!_scrollview){
        UIScrollView *sc = [[UIScrollView alloc]init];
        CGSize size = self.view.frame.size;
        size.height *= 2;
        sc.contentSize = size;
        
        _scrollview = sc;
    }
    return _scrollview;
}


@end
