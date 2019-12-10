//
//  NetAsk.h
//  FirstDemo
//
//  Created by edward on 2019/11/22.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetAsk : NSObject
+(instancetype)GetInstance;
+ (instancetype)alloc;
-(void)IsNetWorking;
-(void)POST:(NSString *)URL parameters:(id)parameters isXML:(BOOL)isXML resultcom:(void (^)(id _Nullable bl))comp;
-(void)GET:(NSString *)URL parameters:(id)parameters isXML:(BOOL)isXML resultcom:(void (^)(NSDictionary *bl))comp;
-(void)PUT:(NSString *)URLString parameters:(id)parameters isXML:(BOOL)isXml resultcom:(void (^)(NSString *bl))comp;
@end

NS_ASSUME_NONNULL_END
