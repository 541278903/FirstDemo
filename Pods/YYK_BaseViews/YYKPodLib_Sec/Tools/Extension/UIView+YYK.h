//
//  UIView+YYK.h
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YYK)
- (NSString *)defaultIdentifier;
- (UINib *)defaultNib;
+ (NSString *)defaultIdentifier;
+(UINib *)defaultNib;
@end

NS_ASSUME_NONNULL_END
