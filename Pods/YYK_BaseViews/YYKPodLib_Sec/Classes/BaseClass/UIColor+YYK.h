//

//

#import <UIKit/UIKit.h>

#define LM_BG_GRAY_F5F5 LMHEXCOLOR(@"#F5F5F5")
#define LM_TITLE_BLACK_222 LMHEXCOLOR(@"#222222")
#define LM_SUB_TITLE_GRAY_999 LMHEXCOLOR(@"#999999")
#define LM_SUB_TITLE_GRAY_EEE LMHEXCOLOR(@"#EEEEEE")
#define LM_SUB_TITLE_GRAY_DDD LMHEXCOLOR(@"#DDDDDD")
#define LM_SUB_TITLE_GRAY_666 LMHEXCOLOR(@"#666666")
#define LM_TEXT_BLACK_333 LMHEXCOLOR(@"#333333")

#define LM_RANDOM_COLOR [UIColor yk_randomColor]

@interface UIColor (YYK)

/**
 随机颜色
 */
+ (UIColor *)yk_randomColor;

/**
 十六进制颜色
 
 @param color 十六进制颜色码
 @return  UIColor
 */
+ (UIColor *)yk_colorWithHexString:(NSString *)color;

/**
 图片平铺
 
 @param name 图片名
 @return 平铺后的色块
 */
+ (UIColor *)yk_tilingWithImageName:(NSString *)name;

/**
 从十六进制字符串获取颜色，
 color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 @param color  十六进制颜色码
 @param alpha 透明度
 @return  UIColor
 */
+ (UIColor *)yk_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @return 纯色图片
 */
- (UIImage *)image;

@end
