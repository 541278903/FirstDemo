//
//  NSObject+YYK.h
//  
//


#import <UIKit/UIKit.h>

@interface UITextField (YYK)<UITextFieldDelegate>

/**
 最大长度
 */
- (void)setMaxLength:(NSInteger)maxLength;

@end
