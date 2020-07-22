//
//  TextViewController.m
//  FirstDemo
//
//  Created by edward on 2020/7/22.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@property(nonatomic,strong) UITextView *textView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KTOP_MARGIN+20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(300);
    }];
    
    UIButton *comfimbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    comfimbutton.backgroundColor = YKHEXCOLOR(@"#5A9CFF");
    comfimbutton.layer.cornerRadius = 10;
    comfimbutton.clipsToBounds = YES;
    [comfimbutton setTitle:@"新 增" forState:UIControlStateNormal];
    [self.view addSubview:comfimbutton];
    [comfimbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(60);
    }];
    @weakify(self);
    [[comfimbutton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       @strongify(self);
//        self.textView
        NSString *str = self.textView.text;
        self.textView.text = [str stringByAppendingString:@"[*]  请注意我的输入 \r\n"];
        
        self.textView.selectedRange = NSMakeRange(self.textView.text.length, 0);
    }];
}
- (UITextView *)textView
{
    if(!_textView)
    {
        UITextView *x = [[UITextView alloc]init];
//        x.backgroundColor = UIColor.blackColor;
        x.font = [UIFont systemFontOfSize:14];
        x.layer.borderWidth = 1;
        x.layer.borderColor = UIColor.blackColor.CGColor;
        x.textAlignment = NSTextAlignmentLeft;
        _textView = x;
    }
    return _textView;
}



@end
