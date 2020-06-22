//
//  UIResponder+YYK.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/30.
//  Copyright © 2020 edward. All rights reserved.
//

#import "UIResponder+YYK.h"



@implementation UIResponder (YYK)

- (void)routerWithPopController
{
    [self routerEventWithName:@"clickbtn" userInfo:nil needBuried:NO];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo needBuried:(BOOL)needBuried
{
    if (needBuried) {
//        [self handleBuriedWithEventName:eventName userInfo:userInfo];
        needBuried = NO;
    }
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo needBuried:needBuried];
}

//- (void)handleBuriedWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
//{
////    LMLog(@"点击 %@ 事件",eventName);
//    if ([userInfo.allKeys containsObject:kUMDigLabel] && [userInfo.allKeys containsObject:kUMDigKey]) {
//        [LMPathDig addDig:userInfo[kUMDigKey]?:@"" name:userInfo[kUMDigLabel]?:@"" params:userInfo[kUMDigParams]?:@{}];
//    } else {
//        [LMPathDig addDig:eventName name:eventName params:@{}];
//    }
//}

@end
