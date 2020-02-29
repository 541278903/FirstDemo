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
@property(nonatomic,strong)UIView *textview;
@property(nonatomic,strong)UIImageView *imageView;
//@property(nonatomic,)
@end
@implementation ScrollerController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self serView];
//    self.view
}
#pragma mark -添加控件，添加约束
-(void)serView{
    [self.view addSubview:self.scrollview];
    [self.scrollview addSubview:self.serchfield];
    [self.scrollview addSubview:self.buttonview];
    [self.scrollview addSubview:self.textview];
    [self.scrollview addSubview:self.imageView];
    
}
#pragma mark -初始化控件
- (UITextField *)serchfield{
    if(!_serchfield){
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, EQUIPMENT_SCREENT_WIDTH -40, 30)];
        textfield.layer.borderWidth = 0.5;
        textfield.layer.borderColor = UIColor.blackColor.CGColor;
        textfield.placeholder = @"搜索框";
        _serchfield = textfield;
    }
    return _serchfield;
}
- (UIView *)buttonview{
    if(!_buttonview){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.serchfield.frame), CGRectGetMaxY(self.serchfield.frame)+20, self.serchfield.frame.size.width, 100)];
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, view.frame.size.width/5, 100)] ;
        [btn1 setTitle:@"按钮1" forState:UIControlStateNormal];
        [btn1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame)+50, 10, view.frame.size.width/5, 100)];
        [btn1 pp_addBadgeWithText:@"99"];
        btn1.layer.borderWidth = 0.5;
        btn1.layer.borderColor = UIColor.blackColor.CGColor;
        [btn1 addTarget:self action:@selector(targe:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:@"按钮2" forState:UIControlStateNormal];
        [btn2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(targe:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 pp_addBadgeWithNumber:12];
        btn2.layer.borderWidth = 0.5;
        btn2.layer.borderColor = UIColor.blackColor.CGColor;
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame)+50,10,view.frame.size.width/5, 100)];
        [btn3 setTitle:@"按钮3" forState:UIControlStateNormal];
        [btn3 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(targe:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 pp_addBadgeWithText:@"ni"];
        btn3.layer.borderWidth = 0.5;
        btn3.layer.borderColor = UIColor.blackColor.CGColor;
        [view addSubview:btn1];
        [view addSubview:btn2];
        [view addSubview:btn3];
        _buttonview = view;
    }
    return _buttonview;
}
- (UIView *)textview{
    if(!_textview){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.buttonview.frame), CGRectGetMaxY(self.buttonview.frame)+50, CGRectGetWidth(self.buttonview.frame), 200)];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = UIColor.blackColor.CGColor;
        UITextView *tview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
        tview.text = @"最新合同";
        [view addSubview:tview];
        _textview = view;
    }
    return _textview;
}

- (UIImageView *)imageView{
    if(!_imageView){
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textview.frame), CGRectGetMaxY(self.textview.frame)+50, CGRectGetWidth(self.buttonview.frame), 500)];
        imageview.layer.borderWidth = 0.5;
        imageview.layer.borderColor = UIColor.blackColor.CGColor;
        _imageView = imageview;
    }
    return _imageView;
}
-(void)targe:(UIButton *)btn{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertc = [UIAlertController alertControllerWithTitle:@"提示" message:@"按钮触发" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertc addAction:ac];
        [btn pp_addBadgeWithNumber:0];
        [self presentViewController:alertc animated:YES completion:nil];
    });
}
-(UIScrollView *)scrollview{
    if(!_scrollview){
        UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPNAVHEIGHT, EQUIPMENT_SCREENT_WIDTH, EQUIPMENT_SCREENT_HEIGHT - TABBAR_HEIGHT)];
        CGSize size = self.view.frame.size;
        size.height = [self setcontentSizeHeigh];
        sc.contentSize = size;
        _scrollview = sc;
    }
    return _scrollview;
}
-(CGFloat)setcontentSizeHeigh{
    CGFloat height = self.serchfield.frame.size.height;
    height += self.buttonview.frame.size.height;
    height += self.textview.frame.size.height;
    height += self.imageView.frame.size.height;
    return height;
}

@end
