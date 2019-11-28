//
//  Toast.h
//  FirstDemo
//
//  Created by edward on 2019/11/28.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Toast : NSObject
+(instancetype)GetInstance;
-(void)showMessage;
@end

NS_ASSUME_NONNULL_END
