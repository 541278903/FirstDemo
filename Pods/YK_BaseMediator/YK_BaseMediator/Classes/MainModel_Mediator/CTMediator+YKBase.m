//
//  CTMediator+YKBase.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import "CTMediator+YKBase.h"

/**target*/
static NSString *baseTarget = @"YKBase";

/**action*/
static NSString *normalVC = @"normalViewController";

@implementation CTMediator (YKBase)
- (UIViewController *)normalBaseViewController:(NSString *)title
{
    UIViewController *vc = [self performTarget:baseTarget action:normalVC params:@{@"title":title} shouldCacheTarget:YES];
    return vc;
}
@end
