//
//  Toast.m
//  FirstDemo
//
//  Created by edward on 2019/11/28.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "Toast.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface Toast()
@end
static Toast *_instance;
@implementation Toast

+(instancetype)GetInstance
{
    if(!_instance){
        _instance = [[Toast alloc]init];
    }
    return _instance;
}

-(void)showMessage
{
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self topMostController].view animated:YES];

     // Set the label text.
     hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}
-(UIViewController *) topMostController {
  UIViewController*topController = [UIApplication sharedApplication].keyWindow.rootViewController;
  while(topController.presentedViewController){
    topController=topController.presentedViewController;
  }
  return topController;
}
@end
