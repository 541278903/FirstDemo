//
//  NSObject+YYK.m
//  
//


#import "UITextField+YYK.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UITextField (YYK)

- (void)setMaxLength:(NSInteger)maxLength
{
    @weakify(self);
    if(maxLength && maxLength != 0) {
        [self.rac_textSignal subscribeNext:^(NSString *x) {
            @strongify(self);
            if (x.length > maxLength) {
                self.text = [x substringToIndex:maxLength];
            }
        }];
    }
//    self.delegate = self;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
//    if (![string isEqualToString:tem]) {
//        return NO;
//    }
//    return YES;
//}

@end
