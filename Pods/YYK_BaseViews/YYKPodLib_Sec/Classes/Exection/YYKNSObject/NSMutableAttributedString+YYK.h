//
//  NSMutableAttributedString+ykExtension.h
//  ykCommonModule
//
//  Created by Arclin on 2019/9/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (YYK)

/**
 整行添加中划线
 */
- (void)yk_addStrikeLine;

/**
 部分区域添加中划线
 */
- (void)yk_addStrikeLineToRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
