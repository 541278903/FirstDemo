//
//  UIBarButtonItem+YYK.h
//  
//


#import <UIKit/UIKit.h>

typedef void(^YKBtnClickedBlock)(UIButton *button);
typedef void(^YKBtnImgClickedBlock)(UIButton *button,UIImageView *imageView);

@interface UIBarButtonItem (YYK)

/**
 拥有尺寸为20，20的图片的按钮
 
 @param image 图片
 @param block 点击回调
 @return UIBarButtonItem
 */
+ (instancetype)yk_itemForButtonWithImage:(UIImage *)image actionBlock:(YKBtnClickedBlock)block;

/**
 拥有字号为17的按钮

 @param title 标题
 @param titleColor 标题颜色
 @param block 回调
 @return UIBarButtonItem
 */
+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title color:(UIColor *)titleColor actionBlock:(YKBtnClickedBlock)block;

+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(YKBtnClickedBlock)block;

+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor buttonWidth:(CGFloat)buttonWidth actionBlock:(YKBtnClickedBlock)block;

+ (instancetype)yk_itemForButtonWithTitle:(NSString *)title image:(UIImage *)image fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(YKBtnImgClickedBlock)block;

@end
