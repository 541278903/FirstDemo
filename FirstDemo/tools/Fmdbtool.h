//
//  Fmdbtool.h
//  FirstDemo
//
//  Created by edward on 2019/10/17.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fmdbtool : NSObject
/// 单例返回
+(instancetype)GetInstance;
//-(BOOL)insertName:(NSString *)name Age:(int)age;
//-(BOOL)insertWithTable:(NSString *)tablename argmes:(NSArray *)dic;
-(NSArray *)serchBySql:(NSString *)sql;
-(BOOL)insertWithTable:(NSString *)tablename argmes:(NSDictionary *)dic;
-(NSArray *)serchTable:(NSString *)tablename argmes:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
