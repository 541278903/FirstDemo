//
//  UITextView+YYK.m
//
//

#import "UITextView+YYK.h"
#import <objc/runtime.h>

@implementation UITextView (YYK)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(setText:);
        SEL swizzledSelector = @selector(mySetText:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

#pragma mark - Method Swizzling

- (void)mySetText:(NSString *)text
{
    if(self.editable == NO) {
        if([text containsString:@"(null)"]) {
            [self mySetText:[text stringByReplacingOccurrencesOfString:@"(null)" withString:@""]];
        }else {
            [self mySetText:text];
        }
    }else {
        [self mySetText:text];
    }
}

@end
