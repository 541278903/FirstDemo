//
//  NSMutableAttributedString+ykExtension.m
//
//
//  Created by Arclin on 2019/9/29.
//

#import "NSMutableAttributedString+YYK.h"

@implementation NSMutableAttributedString (YYK)

- (void)yk_addStrikeLine
{
    [self yk_addStrikeLineToRange:NSMakeRange(0, self.length)];
}

- (void)yk_addStrikeLineToRange:(NSRange)range
{
//    [self addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:range];
    [self addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:range];
}

@end
