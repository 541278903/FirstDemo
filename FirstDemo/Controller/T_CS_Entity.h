//
//  T_CS_Entity.h
//  FirstDemo
//
//  Created by edward on 2020/3/24.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface T_CS_Entity : NSObject

@property(nonatomic,copy)NSString *c_id;
@property(nonatomic,copy)NSString *c_name;
@property(nonatomic,copy)NSString *c_guige;
@property(nonatomic,copy)NSString *c_jinhuo;
@property(nonatomic,copy)NSString *c_shouhuo;
@property(nonatomic,copy)NSString *c_shuliang;
- (instancetype)initWithDic:(NSDictionary *)dic;
//- (NSDictionary *)dicFromObject:(NSObject *)object ;
-(void)update:(NSString *)entity;
@end

NS_ASSUME_NONNULL_END
