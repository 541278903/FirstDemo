//
//  RunTimeController.m
//  FirstDemo
//
//  Created by edward on 2020/3/4.
//  Copyright © 2020 com.Edward. All rights reserved.
//

//#import "RunTimeController.h"

#import <objc/message.h>
#import <objc/runtime.h>
#import "PersonModel+thesec.h"
//#import "PersonModel.h"
@interface RunTimeController ()

@end

@implementation RunTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
//    [self setup2];
//    [self setup3];
//    [self setup4];
    
}
-(void)setup{
    // ⏬runtime 方法调用流程发送消息调用alloc然后调用init 最后创建出对象后调用fshout方法
    PersonModel *p = objc_msgSend(objc_getClass("PersonModel"),sel_registerName("alloc"));
    p = objc_msgSend(p, sel_registerName("init"));
    objc_msgSend(p, sel_registerName("shout"));
    // ⏬runtime 获取对象的实例变量 和变量方法列
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([p class], &count);
    for(int i = 0;i<count;i++){
        NSString *name = [NSString stringWithUTF8String:ivar_getName(list[i])];
//        MLog(@"%@,%@",name,[p valueForKey:name]);

    }
    unsigned int methodcount = 0;
    Method *methodlist = class_copyMethodList([p class], &methodcount);
    for(int i = 0;i<methodcount;i++){
        NSString *name = [NSString stringWithUTF8String:method_getName(methodlist[i])];
//        MLog(@"%@",name);
    }
    
}

// ⏬使用runtime 动态添加一个类
-(void)setup2{
    /** 创建一个新类  步骤一*/
    
    /**注意添加成员变量和方法要在alloccreateClassPair 和 registerClassPair之间 */
    Class myClass = objc_allocateClassPair([NSObject class], "myClass", 0);
    class_addIvar(myClass, "_address", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addIvar(myClass, "_age", sizeof(NSUInteger), log2(sizeof(NSUInteger)), @encode(NSUInteger));
    
    //https://www.jianshu.com/p/c5bdd6f7a68c  动态添加类方法等消息转发技术等说明
    class_addMethod(myClass, NSSelectorFromString(@"mm"), method_getImplementation(class_getInstanceMethod([RunTimeController class], NSSelectorFromString(@"test"))), "v@:");
    /** 注册刚刚新建的类  步骤二*/
    objc_registerClassPair(myClass);
    id object = [[myClass alloc]init];
    [object setValue:@"caonima" forKey:@"address"];
    objc_msgSend(object, sel_registerName("mm"));
    MLog(@"%@",[object valueForKey:@"address"]);
    /** 销毁刚刚新建的类  步骤三*/
    object = nil;
    objc_disposeClassPair(myClass);
    
}
// ⏬使用runtime 给分类category添加属性，category添加属性是不会自动产生getter和setter方法
-(void)setup3{
    PersonModel *person = [[PersonModel alloc]init];
    person.father = @"nihao";
    MLog(@"%@",person.father);
}
// ⏬使用runtime 动态方法解析，防止调用没有定义好的方法产生错误（即消息转发）
-(void)setup4{
    PersonModel *p = [[PersonModel alloc]init];
    [p performSelector:@selector(eat)];
    
}
-(void)test{
    MLog(@"nihao");

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
