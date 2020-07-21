//

#import "NSDate+YYK.h"

@implementation NSDate (YYK)

+ (NSString *)yk_currentDateStrWithFormat:(NSString *)format
{
    NSString *date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    date = [fmt stringFromDate:[NSDate date]];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    return str;
}

- (NSString *)yk_dateStrWithFormat:(NSString *)format
{
    NSString *date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    date = [fmt stringFromDate:self];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    return str;
}

+ (NSString *)yk_dateStrWithTimeStamp:(NSString *)timeStamp format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]]];
    
    return dateStr;
}

- (NSDate *)yk_dateAfterDays:(NSInteger)days
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:days];
    NSDate *date = [calendar dateByAddingComponents:comps toDate:self options:0];
    return date;
}

- (NSDate *)yk_dateAfterHours:(NSInteger)hours
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:hours];
    NSDate *date = [calendar dateByAddingComponents:comps toDate:self options:0];
    return date;
}

+ (BOOL)yk_isTodayWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate *betweenedDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:betweenedDate];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    
    NSDate *currentDate = [NSDate date];
    NSDateComponents *currentDayComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    if (year == currentDayComponents.year &&
        month == currentDayComponents.month &&
        day == currentDayComponents.day) {
        return YES;
    }
    return NO;
}

/**
 取年份
 */
- (NSInteger)yk_year
{
    NSDate  *currentDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger year=[components year];
    return year;
}

/**
 取月份
 */
- (NSInteger)yk_month
{
    NSDate  *currentDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
    
    NSInteger month=[components month];
    return month;
}

/**
 取日期
 */
- (NSInteger)yk_day
{
    NSDate  *currentDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger day=[components day];
    return day;
}

/**
 取小时
 */
- (NSInteger)yk_hour
{
    NSDate  *currentDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:currentDate];
    
    NSInteger day=[components hour];
    return day;
}

/**
 取分钟
 */
- (NSInteger)yk_minute
{
    NSDate  *currentDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:currentDate];
    
    NSInteger day=[components minute];
    return day;
}

@end
