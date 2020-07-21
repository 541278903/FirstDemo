//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (YYK)

//- (UIImageView *(^)(CGFloat x))yk_x;
//- (UIImageView *(^)(CGFloat y))yk_y;
//- (UIImageView * (^)(CGFloat maxX))yk_MaxX;
//- (UIImageView * (^)(CGFloat maxY))yk_MaxY;
//- (UIImageView *(^)(CGFloat width))yk_width;
//- (UIImageView *(^)(CGFloat height))yk_height;
//- (UIImageView *(^)(UIColor *backgroundColor))yk_backgroundColor;
//- (UIImageView *(^)(CGRect frame))yk_frame;
//- (UIImageView * (^)(CGFloat centerX))yk_centerX;
//- (UIImageView * (^)(CGFloat centerY))yk_centerY;
//- (UIImageView * (^)(CGFloat radius))yk_raduis;
//- (UIImageView * (^)(UIColor *borderColor))yk_borderColor;

- (UIImageView *(^)(NSString *imageName))yk_imageNamed;
- (UIImageView *(^)(NSString *imageName))yk_highlightImageNamed;
- (UIImageView * (^)(UIViewContentMode mode))yk_mode;

@end

NS_ASSUME_NONNULL_END
