//
//  BaseAlertCenter.h
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YKAlertCenter : NSObject

/** 提示内容 */
+ (void)showMessage:(NSString *)message;
/** 提示内容 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view;

/** 开始加载 */
+ (void)showLoading:(NSString *)message;

/** 结束加载 */
+ (void)dissLoading;

@end





