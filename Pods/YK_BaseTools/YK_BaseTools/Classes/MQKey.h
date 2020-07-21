//
//  MQKey.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/17.
//  Copyright © 2020 edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQKey : NSObject

+(MQKey *)CreateMqKey:(NSArray *)keys;
-(NSString *)GetMqKeyStr;
-(NSArray *)GetMqKeyArr;
-(MQKey * (^)(MQKey *x))JoinKey;

@end

NS_ASSUME_NONNULL_END
