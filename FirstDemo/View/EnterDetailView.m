//
//  EnterDetailView.m
//  FirstDemo
//
//  Created by edward on 2020/7/22.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "EnterDetailView.h"
#import <Masonry/Masonry.h>

@interface EnterDetailView()


@end

@implementation EnterDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.4);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
    }];
}
- (UILabel *)titleLabel
{
    if( !_titleLabel )
    {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIColor.blackColor;
//        label.backgroundColor = UIColor.redColor;
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UITextField *)textField
{
    if(!_textField)
    {
        UITextField *textField = [[UITextField alloc]init];
        textField.backgroundColor = YKHEXCOLOR(@"#F4F4F4");
        textField.placeholder = @"请输入内容";
        textField.layer.cornerRadius = 5;
        textField.clipsToBounds = YES;
        _textField = textField;
    }
    return _textField;
}

@end
