//
//  CTMediator+YKBase.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import <CTMediator/CTMediator.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (YKBase)
/**
 获取普通的控制器
 */
- (UIViewController *)normalBaseViewController:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
