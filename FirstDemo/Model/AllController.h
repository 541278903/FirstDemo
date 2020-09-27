//
//  AllController.h
//  FirstDemo
//
//  Created by edward on 2019/11/25.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllController : NSObject{
    //实例对象  存放采用硬编码，根据起始地址的偏移量访问便令，编译后写死在内存  不能动态进行操作
//    @protected 子类可见，其他类为私有的
//    @private 完全私有
//    @public  公开变量
    
}
//atomic，即会对setter方法加锁，相应付出系统资源代价，而nonatomic为不加锁，提高多线程并发性
//在花括号外定义的属性为 属性对象，属性对象可以通过s属性特质分别管理内存，多线程，读写控制管理  ，只有属性能够被动态加载删除
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSString *ConName;
@property(nonatomic,strong)UIViewController *ConView;
- (instancetype)initWithName:(NSString *)name  Con:(UIViewController *)con;
-(void)eat;
//week和assign 的区别，week修饰的指针变量在所指的对象释放时会自动将变量指针置nil，而assgin不行。\
assign主要修饰简单的“纯量类型”，即week修饰OC对象，assign修饰非OC对象

@end

NS_ASSUME_NONNULL_END
