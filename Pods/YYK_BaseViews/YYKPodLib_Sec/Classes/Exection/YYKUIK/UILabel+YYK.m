//
//  UILabel+YYK.m
//
//


#import "UILabel+YYK.h"
#import <objc/runtime.h>

@implementation UILabel (DKExtension)

- (UILabel *)yk_unlimitedLine
{
    self.numberOfLines = 0;
    return self;
}

- (UILabel *(^)(NSInteger number))yk_numberOfLine
{
    return ^UILabel *(NSInteger number){
        self.numberOfLines = number;
        return self;
    };
}

- (UILabel *(^)(UIColor *textColor))yk_textColor
{
    return ^UILabel *(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment alignment))yk_textAlignment
{
    return ^UILabel *(NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}

- (UILabel *(^)(NSString *text))yk_text
{
    return ^UILabel *(NSString *text){
        self.text = text;
        return self;
    };
}

- (UILabel *(^)(NSAttributedString *))yk_attrText
{
    return ^UILabel *(NSAttributedString *text){
        self.attributedText = text;
        return self;
    };
}

- (UILabel *(^)(NSInteger, UIFontWeight))yk_font
{
    return ^UILabel *(NSInteger fontSize,UIFontWeight weight){
        self.font = [UIFont systemFontOfSize:fontSize weight:weight];
        return self;
    };
}

- (UILabel *(^)(NSInteger))yk_fontSize
{
    return ^UILabel *(NSInteger fontSize){
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifdef LM_AUTO_TOLOCAL
        Class class = [self class];
        SEL originalSelector = @selector(setText:);
        SEL swizzledSelector = @selector(mySetText:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);

        SEL originalSelector2 = @selector(initWithCoder:);
        SEL swizzledSelector2 = @selector(myInitWithCoder:);
        
        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
        Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSelector2);
        method_exchangeImplementations(originalMethod2, swizzledMethod2);
#else
        [self expectNull];
#endif
//        SEL originalSelector3 = @selector(setFont:);
//        SEL swizzledSelector3 = @selector(mySetFont:);
//        
//        Method originalMethod3 = class_getInstanceMethod(class, originalSelector3);
//        Method swizzledMethod3 = class_getInstanceMethod(class, swizzledSelector3);
//        method_exchangeImplementations(originalMethod3, swizzledMethod3);

    });
}

+ (void)expectNull
{
    Class class = [self class];
    
    SEL originalSelector = @selector(setText:);
    SEL swizzledSelector = @selector(myNullSetText:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

#pragma mark - Method Swizzling

- (instancetype)myInitWithCoder:(NSCoder *)aDecoder {
    UILabel *label = [self myInitWithCoder:aDecoder];
    if (label) {
//        [self toLocal];
//        if (IS_IPAD && label.font.pointSize < 20) {
//            label.font = label.font; // 触发下面交换后的set方法
//        }
    }
    return label;
}

- (void)mySetText:(NSString *)text
{
    if([text containsString:@"(null)"]) {
        [self mySetText:[text stringByReplacingOccurrencesOfString:@"(null)" withString:@""]];
    } else {
//        text = text.toLocal;
        [self mySetText:text];
    }
}

- (void)myNullSetText:(NSString *)text
{
    if([text containsString:@"(null)"]) {
        [self myNullSetText:[text stringByReplacingOccurrencesOfString:@"(null)" withString:@""]];
    } else {
        [self myNullSetText:text];
    }
}
- (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString*string1 = [string stringByAppendingString:subStr];
    NSString *temp;
    for(int i =0; i < string.length; i ++) {
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject: [NSValue valueWithRange:range]];
        }
    }
    return rangeArray;
}
- (void)highlightKeyword:(NSString *)keyword originString:(NSString *)originString color:(UIColor *)color
{
    NSArray *locationArr = [self rangeOfSubString:keyword inString:originString];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:originString];
    for (int i=0; i<locationArr.count; i++) {
        if (i%2==0) {
            NSInteger location = [locationArr[i] rangeValue].location;
            NSInteger length = keyword.length;
            if (location + keyword.length > attstr.length) {
                length = attstr.length - location;
            }
            [attstr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, length)];
        }
    }
    self.attributedText = attstr;
}

- (void)yk_setText:(NSString *)text withLineSpacing:(NSInteger)lineSpacing color:(UIColor *)color fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    NSAttributedString *attSring = [[NSAttributedString alloc] initWithString:text attributes:
                                    @{
                                      NSForegroundColorAttributeName:color,
                                      NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                      NSParagraphStyleAttributeName:style
                                      }];
    self.attributedText = attSring;
}

- (void)yk_setText:(NSString *)text withLineSpacing:(NSInteger)lineSpacing max:(BOOL)isMax color:(UIColor *)color fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if (isMax) {
        style.maximumLineHeight = lineSpacing;
    } else {
        style.minimumLineHeight = lineSpacing;
    }
    NSAttributedString *attSring = [[NSAttributedString alloc] initWithString:text attributes:
                                    @{
                                      NSForegroundColorAttributeName:color,
                                      NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                      NSParagraphStyleAttributeName:style
                                      }];
    self.attributedText = attSring;
}

- (void)setColor:(UIColor *)color fontSize:(NSInteger)fontSize
{
    [self setColor:color fontSize:fontSize weight:UIFontWeightRegular];
}

- (void)setColor:(UIColor *)color fontSize:(NSInteger)fontSize weight:(UIFontWeight)weight
{
    self.textColor = color;
    self.font = [UIFont systemFontOfSize:fontSize weight:weight];
}

//- (void)mySetFont:(UIFont *)font
//{
//    if (IS_IPAD && font.pointSize < 20) {
//        CGFloat size = font.pointSize * LMScale;
//        if (size > 20) size = 20;
//        font = [UIFont systemFontOfSize:size];
//    }
//    [self mySetFont:font];
//}


@end
