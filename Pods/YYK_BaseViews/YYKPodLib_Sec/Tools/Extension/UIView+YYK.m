//
//  UIView+YYK.m
//  YYKPodLib_Sec
//
//  Created by Shenzhi on 2020/5/26.
//  Copyright © 2020 edward. All rights reserved.
//

#import "UIView+YYK.h"


@implementation UIView (YYK)
- (NSString *)defaultIdentifier
{
    return NSStringFromClass([self class]);
}

- (UINib *)defaultNib
{
    UINib *nib = [UINib nibWithNibName:[self defaultIdentifier] bundle:[NSBundle bundleForClass:self.class]];
//    return [UINib nibWithNibName:[self defaultIdentifier] bundle:nil];
    return nib;
}
+(NSString *)defaultIdentifier
{
    return NSStringFromClass([self class]);
}

+ (UINib *)defaultNib
{
    UINib *nib = [UINib nibWithNibName:[self defaultIdentifier] bundle:[NSBundle bundleForClass:self.class]];
//    return [UINib nibWithNibName:[self defaultIdentifier] bundle:nil];
    return nib;
}
@end
