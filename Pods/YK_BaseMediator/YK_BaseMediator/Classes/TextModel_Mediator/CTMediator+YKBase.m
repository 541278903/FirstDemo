//
//  CTMediator+YKBase.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import "CTMediator+YKBase.h"

@implementation CTMediator (YKBase)
- (UIViewController *)normalBaseViewController:(NSDictionary *)params
{
    UIViewController *vc = [self performTarget:@"YKBase" action:@"normalViewController" params:params shouldCacheTarget:YES];
    return vc;
}
@end
