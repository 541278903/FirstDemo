

#import <UIKit/UIKit.h>
#import "UIDevice+YYK.h"

#define IS_IPHONE_X [UIDevice isIPhoneXSeries]
#define YKScreenW [UIScreen mainScreen].bounds.size.width
#define YKScreenH [UIScreen mainScreen].bounds.size.height
#define KTabBar_HEIGHT (IS_IPHONE_X ? 83 : 49)
#define KTOP_MARGIN (IS_IPHONE_X ? 88 : 64)
#define KBottom_HEIGHT (IS_IPHONE_X ? 34 : 0)

static inline UIEdgeInsets yk_safeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsMake(KTOP_MARGIN, 0, 0, KBottom_HEIGHT);
}

typedef  NS_ENUM(NSInteger,YKShadowPathType) {
    YKShadowPathTop,
    YKShadowPathBottom,
    YKShadowPathLeft,
    YKShadowPathRight,
    YKShadowPathCommon,
    YKShadowPathAround
};

@interface UIView (YYK)

#pragma mark - frame extension

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat maxX;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat maxY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
- (CGFloat) maxX;
- (CGFloat) minX;
- (CGFloat) maxY;
- (CGFloat) minY;

#pragma mark -chain
+ (instancetype)instance;
- (UIView * (^)(CGFloat x))yk_x;
- (UIView * (^)(CGFloat maxX))yk_MaxX;
- (UIView * (^)(CGFloat centerX))yk_centerX;
- (UIView * (^)(CGFloat y))yk_y;
- (UIView * (^)(CGFloat maxY))yk_MaxY;
- (UIView * (^)(CGFloat centerY))yk_centerY;
- (UIView * (^)(CGFloat width))yk_width;
- (UIView * (^)(CGFloat height))yk_height;
- (UIView * (^)(UIColor *backgroundColor))yk_backgroundColor;
- (UIView * (^)(CGRect frame))yk_frame;
- (UIView * (^)(CGFloat radius))yk_raduis;
- (UIView * (^)(UIColor *borderColor))yk_borderColor;

- (instancetype)yk_clipToBounds;
- (instancetype)yk_sizeToFit;
- (instancetype(^)(UIView *superView))yk_addTo;

#pragma mark - 添加xib配置属性
/** 边框颜色 */
@property (nonatomic, strong) IBInspectable UIColor *BorderColor;
/** 边框宽度 */
@property (nonatomic, assign) IBInspectable CGFloat BorderWidth;
/** 圆角半径 */
@property (nonatomic, assign) IBInspectable CGFloat CornerRadius;
/** 完全圆角 - 高度与屏幕高度的比例 */
@property (nonatomic, assign) IBInspectable CGFloat RadiusScopeH;
/** 完全圆角 正方形时，宽度与屏幕宽度的比例 */
@property (nonatomic, assign) IBInspectable CGFloat RadiusScopeW;

/**
 深复制 View
 
 @return 新的 View
 */
- (UIView *)yk_duplicate;

/**
 设置圆角
 
 @param cornerRadius 圆角值
 */
- (void)yk_setCornerRadius:(CGFloat)cornerRadius;

/**
 给View添加阴影
 */
- (void)yk_addShadowToView;
- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset;
- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset size:(CGFloat)size;
- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;
- (void)yk_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius layerRaduis:(CGFloat)layerRaduis;
- (void)yk_viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(YKShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth;
/**
 添加毛玻璃效果
 
 @param effcet 添加的样式
 */
- (void)yk_addBlurEffectStyle:(UIBlurEffectStyle)effcet;

/**
 添加圆角边框
 
 @param cornerRadius 圆角角度
 @param width 边框宽度
 @param color 边框颜色
 */
- (void)yk_addCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 判断两个View是否有交集
 
 @param view 另一个 view
 @return YES/NO
 */
- (BOOL)yk_intersectWithView:(UIView *)view;

/**
 截屏
 
 @param afterUpdates 视图加载完成后截图
 @return 截屏 View
 */
- (UIView *)yk_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;

/**
 添加一个tap手势并处理回调
 
 @param tapCallback 回调
 */
- (void)yk_tapOnView:(void(^)(UITapGestureRecognizer *tap))tapCallback;

/**
 添加一个longPress手势并处理回调

 @param second 长按最短秒数
 @param pressCallback 长按回调
 */
- (void)yk_longPressBySecond:(NSInteger)second onView:(void(^)(UILongPressGestureRecognizer *longPress))pressCallback;

/**
 获取同名的reuse ID
 
 @return reuse ID
 */
+ (NSString *)defaultIdentifier;

/**
 获取同名的nib
 
 @return nib
 */
+ (UINib *)defaultNib;

/**
 添加渐变

 @param beginColor 起始颜色
 @param endColor 结束颜色
 @param cornerRadius 圆角半径
 */
- (void)yk_addGradientLayerWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius;
- (void)yk_addVerticalGradientLayerWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius;

/**
 给指定的角加圆角效果
 
 @param radius 半径
 @param corners 需要加圆角的角角
 */
- (void)yk_addRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;

/// 适配iOS11以上加圆角
/// @param corners 需要加圆角的角角
/// @param cacorners 需要加圆角的角角
/// @param raduis 半径
- (void)yk_addCornerWithCorners:(UIRectCorner)corners cacorners:(CACornerMask)cacorners radius:(CGFloat)raduis;
- (void)yk_addCornerWithCorners:(UIRectCorner)corners cacorners:(CACornerMask)cacorners radius:(CGFloat)radius borderColor:(UIColor *)borderColor;

- (UIImage *)yk_screenshot;

- (UIImage *)yk_screenshotForCroppingRect:(CGRect)croppingRect;

/**
 让view可拖动

 @param parentView 父view
 */
- (void)yk_makeViewDragableInParentView:(UIView *)parentView;
- (void)yk_makeViewDragableInParentView:(UIView *)parentView lastXInset:(CGFloat)xInset;

/// 在自身上面绘制虚线
/// @param lineLength 虚线单格长度
/// @param lineSpacing 虚线内间隔
/// @param lineColor 虚线颜色
/// @param isHorizonal 是否横向
- (void)yk_drawLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

@end
