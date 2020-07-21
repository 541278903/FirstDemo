
#import "UIImageView+YYK.h"

@implementation UIImageView (YYK)

- (UIImageView *(^)(NSString * _Nonnull))yk_imageNamed
{
    return ^UIImageView *(NSString *imageName) {
        self.image = [UIImage imageNamed:imageName];
        return self;
    };
}

- (UIImageView * _Nonnull (^)(NSString * _Nonnull))yk_highlightImageNamed
{
    return ^UIImageView *(NSString *imageName) {
        self.highlightedImage = [UIImage imageNamed:imageName];
        return self;
    };
}

- (UIImageView * (^)(UIViewContentMode mode))yk_mode
{
    return ^UIImageView *(UIViewContentMode contentMode) {
        self.contentMode = contentMode;
        return self;
    };
}

@end
