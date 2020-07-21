 //
//  UIView+YKExtension.m
//  
//


#import "UIView+YYK.h"
#import <ReactiveObjC/ReactiveObjC.h>
@implementation UIView (YYK)


#pragma mark - frame extension

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX
{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

#pragma mark -chain

+ (instancetype)instance
{
    return [[self alloc] init];
}

- (UIView * (^)(CGFloat x))yk_x
{
    return ^UIView *(CGFloat x) {
        self.x = x;
        return self;
    };
}

- (UIView *(^)(CGFloat))yk_MaxX
{
    return ^UIView *(CGFloat maxX) {
        self.x = maxX - self.width;
        return self;
    };
}

- (UIView *(^)(CGFloat))yk_MaxY
{
    return ^UIView *(CGFloat maxY) {
        self.y = maxY - self.height;
        return self;
    };
}

- (UIView *(^)(CGFloat))yk_centerX
{
    return ^UIView *(CGFloat centerX) {
        self.centerX = centerX;
        return self;
    };
}

- (UIView *(^)(CGFloat))yk_centerY
{
    return ^UIView *(CGFloat centerY) {
        self.centerY = centerY;
        return self;
    };
}

- (UIView * (^)(CGFloat y))yk_y {
    return ^UIView *(CGFloat y) {
        self.y = y;
        return self;
    };
}
- (UIView * (^)(CGFloat width))yk_width {
    return ^UIView *(CGFloat width) {
        self.width = width;
        return self;
    };
}
- (UIView * (^)(CGFloat height))yk_height {
    return ^UIView *(CGFloat height) {
        self.height = height;
        return self;
    };
}
- (UIView * (^)(CGRect frame))yk_frame {
    return ^UIView *(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView * (^)(UIColor *))yk_backgroundColor
{
    return ^UIView *(UIColor *backgoundColor) {
        self.backgroundColor = backgoundColor;
        return self;
    };
}

- (instancetype)yk_clipToBounds
{
    self.clipsToBounds = YES;
    return self;
}

- (instancetype (^)(UIView *))yk_addTo
{
    return ^(UIView *superView) {
        [superView addSubview:self];
        return self;
    };
}

- (UIView * (^)(CGFloat radius))yk_raduis
{
    return ^UIView *(CGFloat raduis) {
        self.layer.cornerRadius = raduis;
        return self;
    };
}

- (UIView * (^)(UIColor *borderColor))yk_borderColor
{
    return ^UIView *(UIColor *borderColor) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (instancetype)yk_sizeToFit
{
    [self sizeToFit];
    return self;
}


#pragma mark - 添加xib配置属性

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)BorderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)BorderWidth
{
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    //    [self yk_setCornerRadius:cornerRadius];
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (CGFloat)CornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setRadiusScopeH:(CGFloat)scope
{
    CGFloat selfHeight = [UIScreen mainScreen].bounds.size.height * scope;
    [self setCornerRadius:selfHeight * 0.5];
}

- (void)setRadiusScopeW:(CGFloat)scope
{
    CGFloat selfHeight = [UIScreen mainScreen].bounds.size.width * scope;
    [self setCornerRadius:selfHeight * 0.5];
}

- (CGFloat)RadiusScopeW
{
    return 0; // just hide warning
}

- (CGFloat)RadiusScopeH
{
    return 0; // just hide warning
}

- (UIView *)yk_duplicate
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)yk_setCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.frame = self.bounds;
    self.layer.mask = layer;
}

- (void)yk_addShadowToView
{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.12;//阴影透明度，默认0
    self.layer.shadowRadius = 8;//阴影半径，默认3
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor?:[UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = 3;//阴影半径，默认3
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset size:(CGFloat)size {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor?:[UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = size == 0 ? 3 : size;//阴影半径，默认3
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor?:[UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = opacity;//阴影透明度，默认0
    self.layer.shadowRadius = radius == 0 ? 3 : radius;//阴影半径，默认3
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius layerRaduis:(CGFloat)layerRaduis {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor?:[UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = opacity;//阴影透明度，默认0
    self.layer.shadowRadius = radius == 0 ? 3 : radius;//阴影半径，默认3
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:layerRaduis].CGPath;
}


- (void)yk_viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(YKShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth{
    
    self.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
    self.layer.shadowColor = shadowColor.CGColor;// 阴影颜色
    self.layer.shadowOpacity = shadowOpacity;// 阴影透明度，默认0
    self.layer.shadowOffset = CGSizeZero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = 0;
    sizeWith = self.bounds.size.width;
    sizeHeight = self.bounds.size.height;
    
    if (shadowPathType == YKShadowPathTop) {
        shadowRect = CGRectMake(originX, originY-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == YKShadowPathBottom){
        shadowRect = CGRectMake(originY, sizeHeight-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == YKShadowPathLeft){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == YKShadowPathRight){
        shadowRect = CGRectMake(sizeWith-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == YKShadowPathCommon){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, 2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth/2);
    }else if (shadowPathType == YKShadowPathAround){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY-shadowPathWidth/2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = bezierPath.CGPath;//阴影路径
}

- (void)yk_addBlurEffectStyle:(UIBlurEffectStyle)style
{
    // 给背景添加毛玻璃效果
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.bounds;
    
    [self addSubview:visualEffectView];
}


- (void)yk_addRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners
{
    //设置切哪个直角
    //    UIRectCornerTopLeft     = 1 << 0,  左上角
    //    UIRectCornerTopRight    = 1 << 1,  右上角
    //    UIRectCornerBottomLeft  = 1 << 2,  左下角
    //    UIRectCornerBottomRight = 1 << 3,  右下角
    //    UIRectCornerAllCorners  = ~0UL     全部角
    //得到view的遮罩路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)yk_addCornerWithCorners:(UIRectCorner)corners cacorners:(CACornerMask)cacorners radius:(CGFloat)radius
{
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = cacorners;
    } else {
        // Fallback on earlier versions
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)yk_addCornerWithCorners:(UIRectCorner)corners cacorners:(CACornerMask)cacorners radius:(CGFloat)radius borderColor:(UIColor *)borderColor
{
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = cacorners;
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = 1;
    } else {
        // Fallback on earlier versions
        CAShapeLayer *mask=[CAShapeLayer layer];
        UIBezierPath * path= [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
        mask.path=path.CGPath;
        mask.frame=self.bounds;
        
        CAShapeLayer *borderLayer=[CAShapeLayer layer];
        borderLayer.path=path.CGPath;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.lineWidth = 1;
        borderLayer.frame = self.bounds;
        self.layer.mask = mask;
        [self.layer addSublayer:borderLayer];
    }
}

- (void)yk_addGradientLayerWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = @[(id)beginColor.CGColor,(id)endColor.CGColor];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradient atIndex:0];
}

- (void)yk_addVerticalGradientLayerWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = @[(id)beginColor.CGColor,(id)endColor.CGColor];
    gradient.startPoint = CGPointMake(0.5, 1);
    gradient.endPoint = CGPointMake(0.5, 0);
    gradient.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradient atIndex:0];
}

- (void)yk_addCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    if (cornerRadius != 0) {
        self.layer.cornerRadius = cornerRadius;
    }
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (BOOL)yk_intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (UIView *)yk_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates
{
    if([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:context];
        UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *snapView = [[UIImageView alloc] initWithImage:targetImage];
        snapView.frame = self.frame;
        return snapView;
    }else {
        return [self snapshotViewAfterScreenUpdates:afterUpdates];
    }
}

- (void)yk_tapOnView:(void(^)(UITapGestureRecognizer *tap))tapCallback
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
    [self addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        if (tapCallback) {
            tapCallback(x);
        }
    }];
}

- (void)yk_longPressBySecond:(NSInteger)second onView:(void(^)(UILongPressGestureRecognizer *longPress))pressCallback {
   self.userInteractionEnabled = YES;
   UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:nil action:nil];
   longPress.minimumPressDuration = second;
   [self addGestureRecognizer:longPress];
   [longPress.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
       if (pressCallback) {
           pressCallback(x);
       }
   }];
}

+ (NSString *)defaultIdentifier
{
    return NSStringFromClass([self class]);
}

+ (UINib *)defaultNib
{
    UINib *nib = [UINib nibWithNibName:[self defaultIdentifier] bundle:[NSBundle bundleForClass:self.class]];
//    return [UINib nibWithNibName:[self defaultIdentifier] bundle:nil];
    return nib;
}

- (UIImage *)yk_screenshot
{
    return [self yk_screenshotForCroppingRect:self.bounds];
}

- (UIImage *)yk_screenshotForCroppingRect:(CGRect)croppingRect
{
    UIGraphicsBeginImageContextWithOptions(croppingRect.size, NO, [UIScreen mainScreen].scale);
    // Create a graphics context and translate it the view we want to crop so
    // that even in grabbing (0,0), that origin point now represents the actual
    // cropping origin desired:
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) return nil;
    CGContextTranslateCTM(context, -croppingRect.origin.x, -croppingRect.origin.y);
    
    [self layoutIfNeeded];
    [self.layer renderInContext:context];
    
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

- (void)yk_makeViewDragableInParentView:(UIView *)parentView
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [self addGestureRecognizer:pan];
    @weakify(parentView);
    [pan.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(parentView);
        CGPoint point = [x locationInView:parentView];
        if (x.state == UIGestureRecognizerStateEnded || x.state == UIGestureRecognizerStateCancelled ||
            x.state == UIGestureRecognizerStateFailed) {
            if (x.view.center.x < YKScreenW / 2) x.view.x = 0;
            else if (x.view.center.x >= YKScreenW / 2 && x.view.center.x <= YKScreenW) x.view.x = YKScreenW - x.view.width;
        } else {
           x.view.center = point;
        }
    }];
}

- (void)yk_makeViewDragableInParentView:(UIView *)parentView lastXInset:(CGFloat)xInset
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [self addGestureRecognizer:pan];
    @weakify(parentView);
    [pan.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(parentView);
        CGPoint point = [x locationInView:parentView];
        if (x.state == UIGestureRecognizerStateEnded || x.state == UIGestureRecognizerStateCancelled ||
            x.state == UIGestureRecognizerStateFailed) {
            if (x.view.center.x < YKScreenW / 2) x.view.x = 0 - xInset;
            else if (x.view.center.x >= YKScreenW / 2 && x.view.center.x <= YKScreenW) x.view.x = YKScreenW - x.view.width + xInset;
            if (x.view.maxY > YKScreenH - KTabBar_HEIGHT) x.view.y = YKScreenH - KTabBar_HEIGHT - x.view.height - 20;
            else if (x.view.y < 100) x.view.y = 100;
        } else {
           x.view.center = point;
        }
    }];
}

- (void)yk_drawLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    UIView *lineView = self;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    } else {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


@end
