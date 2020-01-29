//
//  NSDate+Extensions.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

#pragma mark - # 基本时间参数
- (NSUInteger)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
#endif
    return [dayComponents year];
}

- (NSUInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
#endif
    return [dayComponents month];
}

- (NSUInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
#endif
    return [dayComponents day];
}


- (NSUInteger)hour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:self];
#endif
    return [dayComponents hour];
}

- (NSUInteger)minute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:self];
#endif
    return [dayComponents minute];
}

- (NSUInteger)second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:self];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:self];
#endif
    return [dayComponents second];
}

- (NSUInteger)weekday
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:self];
    NSInteger weekday = [comps weekday] - 1;
    weekday = weekday == 0 ? 7 : weekday;
    return weekday;
}

- (NSUInteger)dayInMonth
{
    switch (self.month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return self.isLeapYear ? 29 : 28;
    }
    return 30;
}

- (BOOL)isLeapYear {
    if ((self.year % 4  == 0 && self.year % 100 != 0) || self.year % 400 == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - # 日期格式化
/// YYYY年MM月dd日
- (NSString *)formatYMD
{
    return [NSString stringWithFormat:@"%lu年%02lu月%02lu日", (unsigned long)self.year, (unsigned long)self.month, (unsigned long)self.day];
}

/// 自定义分隔符
- (NSString *)formatYMDWithSeparate:(NSString *)separate
{
    return [NSString stringWithFormat:@"%lu%@%02lu%@%02lu", (unsigned long)self.year, separate, (unsigned long)self.month, separate, (unsigned long)self.day];
}

/// MM月dd日
- (NSString *)formatMD
{
    return [NSString stringWithFormat:@"%02lu月%02lu日", (unsigned long)self.month, (unsigned long)self.day];
}

/// 自定义分隔符
- (NSString *)formatMDWithSeparate:(NSString *)separate
{
    return [NSString stringWithFormat:@"%02lu%@%02lu", (unsigned long)self.month, separate, (unsigned long)self.day];
}

/// HH:MM:SS
- (NSString *)formatHMS
{
    return [NSString stringWithFormat:@"%02lu:%02lu:%02lu", (unsigned long)self.hour, (unsigned long)self.minute, (unsigned long)self.second];
}

/// HH:MM
- (NSString *)formatHM
{
    return [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)self.hour, (unsigned long)self.minute];
}

/// 星期几
- (NSString *)formatWeekday
{
    switch([self weekday]) {
        case 1:
            return NSLocalizedString(@"星期一", nil);
        case 2:
            return NSLocalizedString(@"星期二", nil);
        case 3:
            return NSLocalizedString(@"星期三", nil);
        case 4:
            return NSLocalizedString(@"星期四", nil);
        case 5:
            return NSLocalizedString(@"星期五", nil);
        case 6:
            return NSLocalizedString(@"星期六", nil);
        case 7:
            return NSLocalizedString(@"星期天", nil);
        default:
            break;
    }
    return @"";
}

/// 月份
- (NSString *)formatMonth {
    switch(self.month) {
        case 1:
            return NSLocalizedString(@"一月", nil);
        case 2:
            return NSLocalizedString(@"二月", nil);
        case 3:
            return NSLocalizedString(@"三月", nil);
        case 4:
            return NSLocalizedString(@"四月", nil);
        case 5:
            return NSLocalizedString(@"五月", nil);
        case 6:
            return NSLocalizedString(@"六月", nil);
        case 7:
            return NSLocalizedString(@"七月", nil);
        case 8:
            return NSLocalizedString(@"八月", nil);
        case 9:
            return NSLocalizedString(@"九月", nil);
        case 10:
            return NSLocalizedString(@"十月", nil);
        case 11:
            return NSLocalizedString(@"十一月", nil);
        case 12:
            return NSLocalizedString(@"十二月", nil);
        default:
            break;
    }
    return @"";
}

@end
