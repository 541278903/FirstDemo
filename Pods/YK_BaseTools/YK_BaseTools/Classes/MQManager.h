//
//  MQmanager.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/14.
//  Copyright © 2020 edward. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "MQKey.h"
NS_ASSUME_NONNULL_BEGIN

@interface MQManager : NSObject

+ (instancetype)managerWithPath:(NSString *)path
                andRoutingKey:(MQKey *)routingkey
                andFun:(void(^)(NSString *s))func;
-(void)GetMsg;
+(BOOL)conisClosd;
+(void)GetMsg;
+(void)SendMsg:(NSString *)msg AndKey:(MQKey *)key;

- (RACSignal *)executeSignal;

@end



NS_ASSUME_NONNULL_END
