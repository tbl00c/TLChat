//
//  NSDate+Relation.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Relation)

#pragma mark - 日期关系
- (BOOL)isSameDay:(NSDate *)aDate;
@property (nonatomic, assign, readonly) BOOL isToday;
@property (nonatomic, assign, readonly) BOOL isTomorrow;
@property (nonatomic, assign, readonly) BOOL isYesterday;

- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
@property (nonatomic, assign, readonly) BOOL isThisWeek;
@property (nonatomic, assign, readonly) BOOL isNextWeek;
@property (nonatomic, assign, readonly) BOOL isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
@property (nonatomic, assign, readonly) BOOL isThisMonth;
@property (nonatomic, assign, readonly) BOOL isNextMonth;
@property (nonatomic, assign, readonly) BOOL isLastMonth;

- (BOOL)isSameYearAsDate:(NSDate *)aDate;
@property (nonatomic, assign, readonly) BOOL isThisYear;
@property (nonatomic, assign, readonly) BOOL isNextYear;
@property (nonatomic, assign, readonly) BOOL isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;
@property (nonatomic, assign, readonly) BOOL isInFuture;
@property (nonatomic, assign, readonly) BOOL isInPast;

@property (nonatomic, assign, readonly) BOOL isTypicallyWorkday;
@property (nonatomic, assign, readonly) BOOL isTypicallyWeekend;

#pragma mark - 间隔日期
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes;

#pragma mark - 日期加减
- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateBySubtractingYears:(NSInteger)years;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;

#pragma mark - 日期间隔
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;


@end
