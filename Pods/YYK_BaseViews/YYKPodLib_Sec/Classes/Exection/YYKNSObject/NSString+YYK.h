//
//  NSString+LMExtension.h
//  LMExtension
//
//  Created by Arclin on 16/7/30 庄槟豪 on 16/5/11.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (YYK)

#pragma mark - View 相关

/**
 计算字符串高度

 @param width 宽度
 @param font 字体
 @return 高度
 */
- (CGFloat)yk_heightWithContentWidth:(CGFloat)width font:(UIFont *)font;

- (CGFloat)yk_widthWithContentHeight:(CGFloat)height font:(UIFont *)font;

- (CGSize)yk_sizeWithFontSize:(CGFloat)fontSize;

- (CGSize)yk_heightWithLineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize width:(CGFloat)width;

/**
 阿拉伯数字转中文
 */
+ (NSString *)yk_translation:(NSString *)arebic;

#pragma mark - 日期相关

/**
 时间戳转日期 NSString

 @param format 日期格式
 @return 日期
 
*/
- (NSString *)yk_dateTimeWithLonglongTimeFormat:(NSString *)format;

/**
 日期转换格式

 @param fromFormat 源格式
 @param toFormat 目的格式
 @return 转换后的时间
 */
- (NSString *)yk_dateStringFromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

/**
 时间戳转时间间隔

 @return 时间间隔
 */
- (NSString *)yk_timeInterval;


/**
 时间戳转时间间隔，只精确到天数

 @return 时间间隔
 */
- (NSString *)yk_dayTimeInterval;

/**
 时间转换为剩余时间，精确到天
 
 @return 剩余时间
 */
- (NSString *)yk_timeRemain;


/**
 时间转换为剩余时间，精确到毫秒

 @return 剩余时间
 */
- (NSString *)yk_timeRemainMillisecond;

/**
 NSString 转 NSDate

 @param format 日期格式
 @return NSDate
 */
- (NSDate *)yk_convertToDateWithFormat:(NSString *)format;

/**
 返回一个字符串的时间距离 eg:10分钟前 / 1小时前
 
 @param longLongTime 时间戳
 @return 时间戳距当前时间的距离
 */
+ (NSString *)yk_distanceWithTime:(NSString *)longLongTime;


#pragma mark - 进制相关

/**
　十进制转十六进制

 @param denary 十进制整型
 @param length 十六进制长度
 @return 十六进制字符串
 */
- (instancetype)yk_hexStringWithDenary:(NSInteger)denary formatLength:(NSInteger)length;

/**
 十六进制字符串转补码
 */
- (instancetype)yk_complementHexString;

/// 字符串转字典
/// @param jsonString 原始字符
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark - 加密 / 解码 相关

/**
 MD5 加密
 
 @return MD5 String
 */
- (NSString *)yk_md5;

/**
 解码url编码

 @return 解码后的字符串
 */
- (NSString *)yk_decodeFromPercentEscapeString;

#pragma mark - 文件操作相关

/**
 把比特数转为需要的内存表现形式

 @param fileByteSize 比特数
 @return 表示内存的字符串
 */
+ (instancetype)yk_fileSizeToString:(unsigned long long)fileByteSize;


#pragma mark - 文本相关

/**
 格式化字符串，并过滤格式化后的字符串中的(null)

 @param format 格式
 @return 格式化后，过滤掉@"(null)"的字符串
 */
+ (instancetype)yk_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 获得拼音

 @return 拼音字符串
 */
- (NSString *)yk_pinYin;

#pragma mark - 验证合法性相关

/**
 是否正确电话号码 (中国大陆)

 @return  YES/NO
 */
- (BOOL)yk_isPhoneNum;

/**
 是否正确 Email格式

 @return  YES/NO
 */
- (BOOL)yk_isEmail;

/**
 是否整型

 @return  YES/NO
 */
- (BOOL)yk_isPureInt;

/**
 是否浮点

 @return  YES/NO
 */
- (BOOL)yk_isPureFloat;

/**
 是否整型或浮点

 @return  YES/NO
 */
- (BOOL)yk_isPureIntOrFloat;

/**
 是否纯汉字

 @return YES/NO
 */
- (BOOL)yk_isHanZi;

/**
 是否含有特殊字符

 @return YES/NO
 */
- (BOOL)yk_isHaveIllegalChar;

/**
 判空

 @return YES/NO
 */
- (BOOL)isEmpty;

/**
 价格，格式 (￥9.99)

 @return 价格
 */
- (NSString *)yk_price;

/**
 是否是身份证号码

 @return BOOL
 */
- (BOOL)verifyIDCardNumber;


/**
 搜索字串

 @param subStr 子串
 @param string 父串
 @return 所有位置(NSValue(NSRange))
 */
+ (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string;

/** 判断Emoji */
- (BOOL)yk_isEmoji;


/**
 分数星星
*/
+ (NSString *)starWithScore:(NSString *)score;

/**
 带了行距的字符串
 */
- (NSAttributedString *)yk_stringWithLineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize color:(UIColor *)color;


/**
 创建富文本字符串
 */
+ (NSMutableAttributedString *)yk_totalString:(NSString *)totalString attribute:(NSDictionary *)attribute hightlightString:(NSString *)hightlightString hightlightAttribute:(NSDictionary *)highlightAttribute;

/**
 转成富文本字符串
 */
- (NSMutableAttributedString *)yk_attribute:(NSDictionary *)attribute hightlightString:(NSString *)hightlightString hightlightAttribute:(NSDictionary *)highlightAttribute;



/**
 多个高亮元素
 */
- (NSMutableAttributedString *)yk_attribute:(NSDictionary *)attribute hightlightArray:(NSArray *)hightlightArray hightlightAttribute:(NSDictionary *)highlightAttribute;
/// 过滤首尾换行和空格
- (NSString *)yk_exceptLineAndSpace;

@end
