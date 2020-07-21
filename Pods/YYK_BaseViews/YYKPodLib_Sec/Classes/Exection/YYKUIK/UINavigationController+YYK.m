//
//  UINavigationController+YYK.m
//
//


#import "UINavigationController+YYK.h"

@implementation UINavigationController (YYK)

- (void)yk_setBarForegroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor
{
    // 导航条背景颜色
    self.navigationBar.barTintColor = backgroundColor;
    self.navigationBar.backgroundColor = backgroundColor;
    // 导航条title颜色
    NSMutableDictionary *barTitleDic = [NSMutableDictionary dictionary];
    barTitleDic[NSForegroundColorAttributeName] = foregroundColor;
    [[UINavigationBar appearance] setTitleTextAttributes:barTitleDic];
}

@end
