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
    NSString *title = params[@"title"]?:@"";
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.title = title;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 200)];
    imageView.image = [UIImage imageNamed:@"ic_askroom_image_delete@3x"];
    [vc.view addSubview:imageView];
    return vc;
}
-(UIViewController *)Action_normalViewControllerTest:(NSDictionary *)params
{
    return [[UIViewController alloc] init];
}
@end
