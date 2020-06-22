//
//  UILabel+YYK.h
//  YYKPodLib_Sec
//
//  Created by edward on 2020/5/30.
//  Copyright © 2020 edward. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YYK)
+(instancetype)instance;
-(UILabel *(^)(NSInteger size))yk_Fontsize;
-(UILabel *(^)(NSString *text))yk_Text;
-(UILabel *(^)(UIColor *textcolor))yk_textcolor;
- (UILabel *(^)(NSTextAlignment alignment))yk_textAlignment;
- (UILabel *(^)(NSInteger number))yk_numberOfLine;
- (UILabel *(^)(UIFont *font))yk_font;
@end

NS_ASSUME_NONNULL_END
