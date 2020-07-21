//
//  YKButton.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/22.
//  Copyright © 2020 edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKButton.h"
@class YKButtonConfig;
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, YKLabelType) {
    YKLabelTypeLabelBottom = 0,
    YKLabelTypeLabelTop,
    YKLabelTypeOnlyImage,
    YKLabelTypeOnlyTilte,
};

@interface YKButton : UIView

@property(nonatomic,copy) NSString *kClickName;

//This method for Frame
+(instancetype)buttonWithFrame:(CGRect)frame btnConfig:(void(^ __nonnull)(YKButtonConfig * config))configblock btnClickTodo:(void(^ __nonnull)(void))doThing;

//This method for Masory
+(instancetype)buttonWithbtnConfig:(void(^ __nonnull)(YKButtonConfig * config))configblock btnClickTodo:(void(^ __nonnull)(void))doThing;
@end

@interface YKButtonConfig : NSObject

//按钮图像
@property(nonatomic,strong) UIImage * image;
//标签名称
@property(nonatomic,copy) NSString * titleName;
//按钮类型
@property (nonatomic, assign) YKLabelType type;
//字体类型
@property(nonatomic,strong) UIFont * font;




@end
NS_ASSUME_NONNULL_END
