//
//  RACSignal+YYK.h
//
//


#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignal (YYK)

- (RACSignal *)filterEmptyString;

@end
