//


#import <Foundation/Foundation.h>

@interface NSDate (YYK)

/**
 根据所给的格式生成一个NSString类型的当前日期

 @param format 日期格式
 @return 当前日期（NSString）
 */
+ (NSString *)yk_currentDateStrWithFormat:(NSString *)format;

/**
 *  日期转字符串
 */
- (NSString *)yk_dateStrWithFormat:(NSString *)format;

/**
 *  把时间戳转成自定义格式的日期字符串
 */
+ (NSString *)yk_dateStrWithTimeStamp:(NSString *)timeStamp format:(NSString *)format;

/**
 某天后的日期

 @param days 天数
 @return NSDate
 */
- (NSDate *)yk_dateAfterDays:(NSInteger)days;


/**
 n小时后

 @param hours 小时
 @return NSDate
 */
- (NSDate *)yk_dateAfterHours:(NSInteger)hours;
/**
 取年份
 */
- (NSInteger)yk_year;

/**
 取月份
 */
- (NSInteger)yk_month;

/**
 取日期
 */
- (NSInteger)yk_day;

/**
 取小时
 */
- (NSInteger)yk_hour;

/**
 取分钟
 */
- (NSInteger)yk_minute;

/// 比较时间戳看看是不是今天
+ (BOOL)yk_isTodayWithTimeInterval:(NSTimeInterval)timeInterval;

@end
