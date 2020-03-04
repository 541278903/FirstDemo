//
//  PersonModel.m
//  FirstDemo
//
//  Created by edward on 2020/3/3.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "PersonModel.h"
@interface PersonModel()

@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)AllController *con;
@end

@implementation PersonModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _con = [[AllController alloc]init];
    }
    return self;
}
-(void)shout{
    MLog(@"...");
}
// ⏬使用runtime 动态方法解析  机制一
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//
//    NSString *str = NSStringFromSelector(sel);
//    if([str isEqualToString:@"eat"]){
//        IMP imp = method_getImplementation(class_getInstanceMethod(self, @selector(shout)));
//        class_addMethod(self, @selector(eat), imp, "");
//    }
//    return [super resolveInstanceMethod:sel];
//}

// ⏬使用runtime 备用接收者 机制二
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    NSString *str = NSStringFromSelector(aSelector);
//    if([str isEqualToString:@"eat"])
//    {
//        return _con;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

// ⏬使用runtime 完整的消息转发机制 机制三
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//    if(!signature && [_con methodSignatureForSelector:aSelector]){
//        signature = [_con methodSignatureForSelector:aSelector];
//    }
//    return signature;
//}
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    if([_con respondsToSelector:anInvocation.selector]){
//        [anInvocation invokeWithTarget:_con];
//    }
//}
@end
