//
//  SendMessageController.m
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "SendMessageController.h"
#import "TButton.h"
#import "MQManager.h"
#import <Masonry/Masonry.h>

@interface SendMessageController ()

@property(nonatomic,strong)UIView *sendKeyView;
@property(nonatomic,strong)UITextView *keytextview;
@property(nonatomic,strong)UIView *messageView;
@property(nonatomic,strong)UITextView *messagetextview;
//@property(nonatomic,strong)TButton *SendBtn;
@property(nonatomic,strong)UIButton *SendBtn;

@end

@implementation SendMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self setAll];
}
-(void)setAll{
    
    [self.view addSubview:self.sendKeyView];

    [self.sendKeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).mas_offset(200);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.offset(100);
    }];
    
    [self.view addSubview:self.messageView];
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.sendKeyView);
        make.top.equalTo(self.sendKeyView.mas_bottom).offset(10);
        make.height.offset(350);
    }];
    [self.view addSubview:self.SendBtn];
    [self.SendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.sendKeyView);
        make.top.equalTo(self.messageView.mas_bottom).offset(10);
        make.height.offset(100);
    }];
    
}
- (UITextView *)keytextview{
    if(!_keytextview){
        UITextView *keytextview = [[UITextView alloc]init];
        _keytextview = keytextview;
    }
    return _keytextview;
}
-(UITextView *)messagetextview
{
    if(!_messagetextview)
    {
        UITextView *textview = [[UITextView alloc]init];
        _messagetextview = textview;
    }
    return _messagetextview;
}
- (UIView *)sendKeyView{
    if(!_sendKeyView){
        UIView *sendkeyv = [[UIView alloc]init];
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.text = @"发送key:";
        [sendkeyv addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(sendkeyv);
            make.height.offset(30);
        }];
        [sendkeyv addSubview:self.keytextview];
        [self.keytextview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(sendkeyv);
            make.top.equalTo(titlelabel.mas_bottom);
        }];
        self.keytextview.text = [NSString stringWithFormat:@"test.%@",[[NSUUID UUID] UUIDString]];
        self.keytextview.font = [UIFont systemFontOfSize:16];
        [self.keytextview.layer setBorderWidth:1];
        [self.keytextview.layer setBorderColor:[UIColor blackColor].CGColor];
        _sendKeyView = sendkeyv;
    }
    return _sendKeyView;
}
- (UIView *)messageView{
    if(!_messageView){
        UIView *messageview = [[UIView alloc]init];
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.text = @"内容:";
        [messageview addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(messageview);
            make.height.offset(30);
        }];
        [messageview addSubview:self.messagetextview];
        [self.messagetextview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(messageview);
            make.top.equalTo(titlelabel.mas_bottom);
        }];
        self.messagetextview.text = @"allready to send";
        self.messagetextview.font = [UIFont systemFontOfSize:16];
        [self.messagetextview.layer setBorderWidth:1];
        [self.messagetextview.layer setBorderColor:[UIColor blackColor].CGColor];
        _messageView = messageview;
    }
    return _messageView;
}
- (UIButton *)SendBtn
{
    if(!_SendBtn)
    {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"发送" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [btn.layer setBorderColor:[UIColor blackColor].CGColor];
        [btn.layer setBorderWidth:1];
        [btn addTarget:self action:@selector(Send) forControlEvents:UIControlEventTouchUpInside];
        _SendBtn = btn;
    }
    return _SendBtn;
}
-(void)Send
{
//    NSLog(@"allready to send");
    [[MQManager GetInstance]SendMsgWith:self.messagetextview.text routingKey:self.keytextview.text];
}



@end
