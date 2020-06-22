//
//  UILabel+YYK.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/30.
//  Copyright © 2020 edward. All rights reserved.
//

#import "UILabel+YYK.h"



@implementation UILabel (YYK)

+(instancetype)instance
{
    return [[self alloc]init];
}

-(UILabel *(^)(NSInteger size))yk_Fontsize
{
    return ^UILabel *(NSInteger size){
        self.font = [UIFont systemFontOfSize:size];
        return self;
    };
}
-(UILabel *(^)(NSString *text))yk_Text
{
    return ^UILabel *(NSString *text)
    {
        self.text = text;
        return self;
    };
}
-(UILabel *(^)(UIColor *textcolor))yk_textcolor
{
    return ^UILabel *(UIColor *textcolor)
    {
        self.textColor = textcolor;
        return self;
    };
}
- (UILabel *(^)(NSTextAlignment alignment))yk_textAlignment
{
    return ^UILabel *(NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}
- (UILabel *(^)(NSInteger number))yk_numberOfLine
{
    return ^UILabel *(NSInteger number){
        self.numberOfLines = number;
        return self;
    };
}
- (UILabel *(^)(UIFont *font))yk_font
{
    return ^UILabel *(UIFont *font){
        self.font = font;
        return self;
    };
}


@end
