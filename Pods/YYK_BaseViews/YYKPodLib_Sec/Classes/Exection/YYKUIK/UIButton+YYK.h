

#import <UIKit/UIKit.h>

typedef void (^ButtonClickedBlock)(UIButton *button);

@interface UIButton (YYK)

- (UIButton *(^)(CGFloat x))yk_x;
- (UIButton *(^)(CGFloat y))yk_y;
- (UIButton * (^)(CGFloat maxX))yk_MaxX;
- (UIButton * (^)(CGFloat maxY))yk_MaxY;
- (UIButton *(^)(CGFloat width))yk_width;
- (UIButton *(^)(CGFloat height))yk_height;
- (UIButton *(^)(UIColor *backgroundColor))yk_backgroundColor;
- (UIButton *(^)(CGRect frame))yk_frame;
- (UIButton * (^)(CGFloat centerX))yk_centerX;
- (UIButton * (^)(CGFloat centerY))yk_centerY;
- (UIButton * (^)(CGFloat radius))yk_raduis;
- (UIButton * (^)(UIColor *borderColor))yk_borderColor;

- (UIButton *(^)(UIColor *titleColor))yk_titleColor;
- (UIButton *(^)(UIColor *titleColor,UIControlState state))yk_titleColorState;
- (UIButton *(^)(NSString *title,UIControlState state))yk_titleState;
- (UIButton *(^)(CGFloat titleFontSize))yk_titleFontSize;
- (UIButton *(^)(UIImage *image))yk_image;
- (UIButton *(^)(UIImage *image))yk_backgroundImage;
- (UIButton *(^)(UIImage *image,UIControlState state))yk_imageState;
- (UIButton *(^)(UIEdgeInsets titleInset))yk_titleInset;
- (UIButton *(^)(UIEdgeInsets imageInset))yk_imageInset;
- (UIButton *(^)(NSString *title))yk_title;

/**
 UIButton 附加 Block 点击回调
 
 @param event 点击状态
 @param action 回调方法
 */
- (void)yk_handleControlEvent:(UIControlEvents)event withBlock:(ButtonClickedBlock)action;

/**
 点击事件的信号
 
 @return 信号
 */
#ifdef RAC
- (RACSignal *)clickSignal;
#endif

@end
