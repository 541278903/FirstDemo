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
-(void)instanceMethod1{
    MLog(@"instanceMethod1");
}
-(void)instanceMethod2{
    MLog(@"instanceMethod2");
}
-(void)shout{
    MLog(@"...");
}
// ⏬使用runtime 交换两种方法
+ (void)load{
    Class class = [self class];
    
    Method insMethod1 = class_getInstanceMethod(class, @selector(instanceMethod1));
    Method insMethod2 = class_getInstanceMethod(class, @selector(instanceMethod2));
    
    //此处为两个方法对调的场景 使用method_exchangeImplementations
//    method_exchangeImplementations(insMethod1, insMethod2);
    
    //重新设置类中某个方法的实现
    
}
// ⏬使用runtime 动态方法解析  机制一
+ (BOOL)resolveInstanceMethod:(SEL)sel{

    NSString *str = NSStringFromSelector(sel);
    if([str isEqualToString:@"eat"]){
        IMP imp = method_getImplementation(class_getInstanceMethod(self, @selector(shout)));
        class_addMethod(self, @selector(eat), imp, "");
    }
    return [super resolveInstanceMethod:sel];
}

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
