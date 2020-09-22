//
//  Target_YKBase.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/9/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import "Target_YKBase.h"

@implementation Target_YKBase


- (UIViewController *)Action_normalViewController:(NSDictionary *)params
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.title = @"你好";
    return vc;
}
@end
