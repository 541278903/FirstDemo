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
@property (atomic, assign) BOOL canceled;
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


-(void)nomalToast
{
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self topMostController].view animated:YES];

     // Set the label text.
     hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //dosomething
        [hud hideAnimated:YES];
    });
}
-(void)annularDeterminate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self topMostController].view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = NSLocalizedString(@"loaddddding...", @"HUD loading title");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        self.canceled = NO;
        //模拟进度条
        float progress = 0.0f;
        while (progress < 1.0f) {
            if (self.canceled) break;
            progress += 0.04f;
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.progress = progress;
            });
            usleep(50000);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
}
-(void)annularDeterminatecancelation{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self topMostController].view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = NSLocalizedString(@"loading????", @"HUD loading title");
    
    [hud.button setTitle:NSLocalizedString(@"Cancel", @"HUD cancel button title") forState:UIControlStateNormal];
    [hud.button addTarget:self action:@selector(cancelWork:) forControlEvents:UIControlEventTouchUpInside];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        //模拟进度条

        self.canceled = NO;
        float progress = 0.0f;
        while (progress < 1.0f) {
            if (self.canceled) break;
            progress += 0.03f;
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.progress = progress;
            });
            usleep(50000);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
}
- (void)cancelWork:(id)sender {
    self.canceled = YES;
}
-(UIViewController *) topMostController {
  UIViewController*topController = [UIApplication sharedApplication].keyWindow.rootViewController;
  while(topController.presentedViewController){
    topController=topController.presentedViewController;
  }
  return topController;
}
@end
