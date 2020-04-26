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

@property(nonatomic,strong)NSString *c_id;
@property(nonatomic,strong)NSString *c_name;
@property(nonatomic,strong)NSString *c_guige;
@property(nonatomic,assign)NSNumber *c_jinhuo;
@property(nonatomic,assign)NSNumber *c_shouhuo;
@property(nonatomic,assign)NSNumber *c_shuliang;
- (instancetype)initWithDic:(NSDictionary *)dic;
//- (NSDictionary *)dicFromObject:(NSObject *)object ;
@end

NS_ASSUME_NONNULL_END
