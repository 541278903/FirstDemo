//
//  NSArray+ykExtension.h
//
//


#import <Foundation/Foundation.h>

@interface NSArray (YYK)

/**
 取出模型数组中某个属性组成数组
 @param propertyName 要取出的属性名
 @return 属性值组成的数组
 */
- (NSArray *)yk_fetchPropertys:(NSString *)propertyName defaultValue:(id)value;

- (NSArray *)yk_fetchPropertys:(NSString *)propertyName otherProperty:(NSString *)otherProperty defaultValue:(id)defaultValue;

- (NSString *)yk_arrayJson;

@end
