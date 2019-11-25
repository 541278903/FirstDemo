//
//  MQManager.h
//  NavigationConOC
//
//  Created by Edward on 2019/9/24.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQManager : NSObject

@property (nonatomic,weak) NSString *key;
+(instancetype)GetInstance;
-(void)GetMsg;
-(void)GetMsgWith:(NSArray *)routingKeys;
-(void)SendMsg:(NSString *)msg;
-(void)SendMsgWith:(NSString *)msg routingKey:(NSString *)routingKey;
@end

NS_ASSUME_NONNULL_END
