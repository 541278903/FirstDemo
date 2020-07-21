//
//  RACSignal+YYK.m
//
//

#import "RACSignal+YYK.h"

@implementation RACSignal (YYK)

- (RACSignal *)filterEmptyString
{
   return [self filter:^BOOL(id value) {
       if ([value isKindOfClass:[NSString class]]) {
           NSString *str = value;
           if (!str || str.length == 0 ) {
               return NO;
           }
           return YES;
       } 
       return YES;
    }];
}

@end
