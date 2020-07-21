

#import "UIAlertController+YYK.h"

@implementation UIAlertController (YYK)

+ (UIAlertController *)yk_alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    return alert;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (UIAlertController *)yk_alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle handle:(void(^)(UIAlertAction *action))handleBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style: UIAlertActionStyleDefault handler:handleBlock];
    [alert addAction:action];
    return alert;
    //    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (UIAlertController *)yk_alertWithOKCancelBtnWithTitle:(NSString *)title message:(NSString *)message clickBtnAtIndex:(YKAlertWithBtnBlock)block
{
    return [self yk_alertWithTitle:title message:message btnTitles:@[@"确认"] clickBtnAtIndex:block];
}

+ (void)yk_alertWithOKCancelBtnWithTitle:(NSString *)title message:(NSString *)message clickBtnAtIndex:(YKAlertWithBtnBlock)block cancel:(void(^)(void))cancelBlock
{
    [self yk_alertWithTitle:title message:message btnTitles:@[@"确认"] clickBtnAtIndex:block cancel:cancelBlock];
}

+ (void)yk_alertWithtPlainText:(NSString *)title isSecure:(BOOL)isSecure message:(NSString *)message placeholder:(NSString *)placehoder keyBoardType:(UIKeyboardType)keyBoardType clickBtnAtIndex:(YKAlertWithTextBlock)block {
    [self yk_alertWithtPlainText:title message:message configureTextField:^(UITextField *textField) {
        textField.keyboardType = keyBoardType;
        textField.placeholder = placehoder;
        textField.secureTextEntry = isSecure;
    } clickBtnAtIndex:block];
}

+ (void)yk_alertWithtPlainText:(NSString *)title message:(NSString *)message configureTextField:(void(^)(UITextField* textField))configureTextField clickBtnAtIndex:(YKAlertWithTextBlock)block
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        if (configureTextField) {
            configureTextField(textField);
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block(0,alertController.textFields.firstObject.text);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

+ (UIAlertController *)yk_alertWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(YKActionWithBtnBlock)block
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSString *title in titles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block([titles indexOfObject:action.title]);
        }];
        [alertController addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:cancelAction];
    return alertController;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

+ (UIAlertController *)yk_alertWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(YKActionWithBtnBlock)block cancel:(void(^)(void))cancelBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSString *title in titles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block([titles indexOfObject:action.title]);
        }];
        [alertController addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    [alertController addAction:cancelAction];
    return alertController;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

+ (UIAlertController *)yk_actionSheetWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(YKActionWithBtnBlock)block
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block([titles indexOfObject:action.title]);
        }];
        [controller addAction:action];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancel];
//    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [vc presentViewController:controller animated:YES completion:nil];
    return controller;
}

+ (UIAlertController *)yk_ipad_actionSheetWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles sourceView:(UIView *)sourceView  clickBtnAtIndex:(YKActionWithBtnBlock)block
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block([titles indexOfObject:action.title]);
        }];
        [controller addAction:action];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancel];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return [self yk_alertWithTitle:title message:message btnTitles:titles clickBtnAtIndex:block];
//        controller.modalPresentationStyle = UIModalPresentationPopover;
//        controller.popoverPresentationController.sourceView = sourceView;
//        controller.popoverPresentationController.sourceRect = sourceView.bounds;
    }
    return controller;
}

@end
