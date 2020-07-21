//
//  MASConstraint+YYK.m
//  BaZiApp
//


#import "MASConstraint+YYK.h"

@implementation MASConstraint (YYK)

- (NSNumber *)yk_constant
{
    NSLayoutConstraint *constraint = [self valueForKeyPath:@"layoutConstraint"];
    return @(constraint.constant);
}

@end
