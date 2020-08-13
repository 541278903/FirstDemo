//
//  YKSocket.h
//  YK_BaseTools
//
//  Created by edward on 2020/8/12.
//  Copyright © 2020 Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKSocket : NSObject

- (instancetype)initWithUrl:(NSURL *)url withaction:(nullable void (^)(id message))action witherroraction:(nullable void (^)(NSError *error))erroraction;

-(void)sentData:(NSString *)data;

-(void)open;

@end

NS_ASSUME_NONNULL_END
