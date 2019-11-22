//
//  DesHelper.h
//  TouchDoc
//
//  Created by Edward on 2019/7/15.
//  Copyright © 2019 Wisefly. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface DesHelper : NSObject
-(NSString *)DecryptUseDES:(NSString *)message :(NSString *)key;
-(NSString *)EncryptUseDES:(NSString *)message :(NSString *)key;
-(NSString *)SetPar:(NSString *)para;
@end

NS_ASSUME_NONNULL_END
