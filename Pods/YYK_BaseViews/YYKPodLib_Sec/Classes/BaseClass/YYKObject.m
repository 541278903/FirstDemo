//
//  YYKObject.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/13.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YYKObject.h"

@implementation YYKObject

-(UIViewController *) topMostController {
  UIViewController*topController = [UIApplication sharedApplication].keyWindow.rootViewController;
  while(topController.presentedViewController){
    topController=topController.presentedViewController;
  }
  return topController;
}

@end
