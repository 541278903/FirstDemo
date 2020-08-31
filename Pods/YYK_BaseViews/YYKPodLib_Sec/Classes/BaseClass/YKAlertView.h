//
//  YKAlertView.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/8/21.
//  Copyright © 2020 edward. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AlertShowType) {
    AlertShowTypeFromBottom = 0,
    AlertShowTypeFromTop,
    AlertShowTypeFromLeft,
};

@interface YKAlertView : UIView

- (instancetype)initViewController:(UIViewController *)viewController showType:(AlertShowType)showType;

-(void)addViewinMainView:(UIView *) view;

-(void)showView;

-(void)dissView;

@end

NS_ASSUME_NONNULL_END