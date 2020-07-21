
#import <UIKit/UIKit.h>

@interface UIDevice (YYK)

// 判断是否有刘海
//+ (BOOL)isIPhoneX NS_DEPRECATED_IOS(11.0, 12.0);

/** 判断是否是 X XR XS XSMax */
+ (BOOL)isIPhoneXSeries;

@end
