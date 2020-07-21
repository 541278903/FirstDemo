//
//  UIBarButtonItem+YYK.m
//  
//

#import "UIBarButtonItem+YYK.h"
#import "UIButton+YYK.h"
#import "UIView+YYK.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (YYK)

+ (instancetype)yk_itemForButtonWithImage:(UIImage *)image actionBlock:(YKBtnClickedBlock)block
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    CGRect rect = btn.frame;
    rect.size = CGSizeMake(30, 30);
    btn.frame = rect;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn yk_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        block(button);
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(YKBtnClickedBlock)block {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn yk_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        if(block) {
            block(button);
        }
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor buttonWidth:(CGFloat)buttonWidth actionBlock:(YKBtnClickedBlock)block {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    btn.width = buttonWidth;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn yk_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        if(block) {
            block(button);
        }
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title image:(UIImage *)image fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(YKBtnImgClickedBlock)block {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 6, 18, 18);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    btn.x = 23;
    
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.frame = CGRectMake(0, 0, imageView.width + btn.width + 5, 30);
    [coverBtn yk_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        if(block) {
            block(button,imageView);
        }
    }];
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageView.width + btn.width + 5, 30)];
    [customView addSubview:imageView];
    [customView addSubview:btn];
    [customView addSubview:coverBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    return item;
}

+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title color:(UIColor *)titleColor actionBlock:(YKBtnClickedBlock)block
{
    return [self yk_itemForButtonWithTitle:title fontSize:14 color:titleColor actionBlock:block];
}

@end
