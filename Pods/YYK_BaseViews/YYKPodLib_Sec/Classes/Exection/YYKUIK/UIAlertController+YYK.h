

#import <UIKit/UIKit.h>

typedef void (^YKAlertWithBtnBlock)(NSInteger index);
typedef void (^YKActionWithBtnBlock)(NSInteger index);
typedef void (^YKAlertWithTextBlock)(NSInteger index,NSString *text);

@interface UIAlertController (YYK)<UIAlertViewDelegate>

/**
 标题+信息+确认按钮
 
 @param title 标题
 @param message 显示信息
 */
+ (UIAlertController *)yk_alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message;

/**
 标题+信息+确认按钮+回调
 
 @param title 标题
 @param message 显示信息
 */
+ (UIAlertController *)yk_alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle handle:(void(^)(UIAlertAction *action))handleBlock;

/** 标题+信息+确认+取消按钮 */
+ (UIAlertController *)yk_alertWithOKCancelBtnWithTitle:(NSString *)title message:(NSString *)message clickBtnAtIndex:(YKAlertWithBtnBlock)block;

/** 标题+信息+确认+取消按钮+取消block */
+ (void)yk_alertWithOKCancelBtnWithTitle:(NSString *)title message:(NSString *)message clickBtnAtIndex:(YKAlertWithBtnBlock)block cancel:(void(^)(void))cancelBlock;

+ (UIAlertController *)yk_alertWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(YKActionWithBtnBlock)block cancel:(void(^)(void))cancelBlock;

/** 标题+信息+确认+取消+文本框 */
+ (void)yk_alertWithtPlainText:(NSString *)title isSecure:(BOOL)isSecure message:(NSString *)message placeholder:(NSString *)placehoder keyBoardType:(UIKeyboardType)keyBoardType clickBtnAtIndex:(YKAlertWithTextBlock)block;
+ (void)yk_alertWithtPlainText:(NSString *)title message:(NSString *)message configureTextField:(void(^)(UITextField* textField))configureTextField clickBtnAtIndex:(YKAlertWithTextBlock)block;

/** 标题+信息+按钮A+...+按钮N */
+ (UIAlertController *)yk_alertWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(YKActionWithBtnBlock)block;

/** 列表：标题+信息+按钮A+...+按钮N */
//+ (UIAlertController *)yk_actionSheetWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(YKActionWithBtnBlock)block;
+ (UIAlertController *)yk_ipad_actionSheetWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles sourceView:(UIView *)sourceView  clickBtnAtIndex:(YKActionWithBtnBlock)block;


@end
