

#import "UIButton+YYK.h"
#import <objc/runtime.h>

@implementation UIButton (YYK)

- (UIButton *(^)(NSString *))yk_title
{
    return ^UIButton *(NSString *title) {
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIColor *titleColor))yk_titleColor
{
    return ^UIButton*(UIColor *titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIColor *titleColor,UIControlState state))yk_titleColorState
{
    return ^UIButton*(UIColor *titleColor,UIControlState state) {
        [self setTitleColor:titleColor forState:state];
        return self;
    };
}

- (UIButton *(^)(NSString *title,UIControlState state))yk_titleState
{
    return ^UIButton*(NSString *title,UIControlState state) {
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton *(^)(CGFloat titleFontSize))yk_titleFontSize
{
    return ^UIButton*(CGFloat titleFontSize) {
        self.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
        return self;
    };
}

- (UIButton *(^)(UIImage *image))yk_image
{
    return ^UIButton*(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIImage *image,UIControlState state))yk_imageState
{
    return ^UIButton*(UIImage *image,UIControlState state) {
        [self setImage:image forState:state];
        return self;
    };
}

- (UIButton *(^)(UIEdgeInsets titleInset))yk_titleInset
{
    return ^UIButton*(UIEdgeInsets titleInset) {
        self.titleEdgeInsets = titleInset;
        return self;
    };
}

- (UIButton *(^)(UIImage *))yk_backgroundImage
{
    return ^UIButton*(UIImage *image) {
        [self setBackgroundImage:image forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIEdgeInsets imageInset))yk_imageInset
{
    return ^UIButton *(UIEdgeInsets inset) {
        self.imageEdgeInsets = inset;
        return self;
    };
}

static char eventKey;

- (void)yk_handleControlEvent:(UIControlEvents)event withBlock:(ButtonClickedBlock)action {
    objc_setAssociatedObject(self, &eventKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(dk_callActionBlock:) forControlEvents:event];
}

- (void)dk_callActionBlock:(UIButton *)sender {
    ButtonClickedBlock block = (ButtonClickedBlock)objc_getAssociatedObject(self, &eventKey);
    if (block) {
        block(sender);
    }
}

#ifdef RAC
- (RACSignal *)clickSignal
{
    return [self rac_signalForControlEvents:UIControlEventTouchUpInside];
}
#endif

@end
