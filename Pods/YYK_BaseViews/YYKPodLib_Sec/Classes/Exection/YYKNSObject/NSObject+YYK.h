//
//  NSObject+ykExtension.h
//  
//


#import <Foundation/Foundation.h>

@interface NSObject (YYK)

/** 深复制对象 */
- (instancetype)yk_deepCopy;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @param mapDict 映射字典
 *
 *  @return 返回属性已赋值的模型
 */
+ (instancetype)yk_modelWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @param mapDict 映射字典
 *  @return 返回属性已赋值的模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @return 返回属性已赋值的模型
 */
+ (instancetype)yk_modelWithDict:(NSDictionary *)dict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @return 返回属性已赋值的模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 方法交换
 
 @param origSelector 方法1
 @param newSelector 方法2
 */
- (void)yk_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 获取当前显示的控制器
 
 @return 当前的控制器
 */
- (id)yk_topViewController;


@end
