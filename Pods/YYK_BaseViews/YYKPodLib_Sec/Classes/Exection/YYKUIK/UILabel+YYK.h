//
//  UILabel+YYK.h
//  
//


#import <UIKit/UIKit.h>

@interface UILabel (YYK)

- (UILabel *(^)(CGFloat x))yk_x;
- (UILabel *(^)(CGFloat y))yk_y;
- (UILabel *(^)(CGFloat maxX))yk_MaxX;
- (UILabel *(^)(CGFloat maxY))yk_MaxY;
- (UILabel *(^)(CGFloat width))yk_width;
- (UILabel *(^)(CGFloat height))yk_height;
- (UILabel *(^)(UIColor *backgroundColor))yk_backgroundColor;
- (UILabel *(^)(CGRect frame))yk_frame;
- (UILabel * (^)(CGFloat centerX))yk_centerX;
- (UILabel * (^)(CGFloat centerY))yk_centerY;
- (UILabel * (^)(CGFloat radius))yk_raduis;
- (UILabel * (^)(UIColor *borderColor))yk_borderColor;

- (UILabel *(^)(UIColor *textColor))yk_textColor;
- (UILabel *(^)(NSString *text))yk_text;
- (UILabel *(^)(NSAttributedString *text))yk_attrText;
- (UILabel *(^)(NSInteger fontSize,UIFontWeight weight))yk_font;
- (UILabel *(^)(NSInteger fontSize))yk_fontSize;
- (UILabel *)yk_unlimitedLine;
- (UILabel *(^)(NSInteger number))yk_numberOfLine;
- (UILabel *(^)(NSTextAlignment alignment))yk_textAlignment;


+ (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string ;

- (void)setColor:(UIColor *)color fontSize:(NSInteger)fontSize weight:(UIFontWeight)weight;

- (void)setColor:(UIColor *)color fontSize:(NSInteger)fontSize;

- (void)yk_setText:(NSString *)text withLineSpacing:(NSInteger)lineSpacing max:(BOOL)isMax color:(UIColor *)color fontSize:(NSInteger)fontSize;

- (void)yk_setText:(NSString *)text withLineSpacing:(NSInteger)lineSpacing color:(UIColor *)color fontSize:(NSInteger)fontSize;

- (void)highlightKeyword:(NSString *)keyword originString:(NSString *)originString color:(UIColor *)color;

@end
