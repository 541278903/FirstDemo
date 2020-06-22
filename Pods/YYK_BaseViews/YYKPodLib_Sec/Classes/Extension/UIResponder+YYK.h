//
//  UIResponder+YYK.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/30.
//  Copyright © 2020 edward. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (YYK)
- (void)routerWithPopController;
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo needBuried:(BOOL)needBuried;
@end

NS_ASSUME_NONNULL_END
