//
//  YYKBaseButton.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKBaseButton.h"
#import "YYKView.h"
@class YYKBaseButtonConfig;
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, YYKLabelType) {
    YYKBaseButtonTypeLabelBottom = 0,
    YYKBaseButtonTypeLabelTop,
    YYKBaseButtonTypeOnlyImage,
    YYKBaseButtonTypeOnlyTilte,
};

@interface YYKBaseButton : YYKView

- (instancetype)initWithFrame:(CGRect)frame AndYYKBaseButtonConfig:(YYKBaseButtonConfig *)config;
//-(instancetype)setBgColor:(UIColor *)color;
@end
@interface YYKBaseButtonConfig : NSObject

//按钮u图像
@property(nonatomic,strong) UIImage * image;
//标签i名称
@property(nonatomic,copy) NSString * titleName;
//动作
@property(nonatomic,assign) SEL target;
//按钮类型
@property (nonatomic, assign) YYKLabelType type;
//响应按钮事件的控制
@property(nonatomic,weak) UIViewController * selfViewController;
//字体类型
@property(nonatomic,strong) UIFont * font;

@end
NS_ASSUME_NONNULL_END
