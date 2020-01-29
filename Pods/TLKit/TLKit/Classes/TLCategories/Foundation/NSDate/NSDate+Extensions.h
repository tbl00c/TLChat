//
//  NSDate+Extensions.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

#pragma mark - 基本时间参数
@property (nonatomic, assign, readonly) NSUInteger year;
@property (nonatomic, assign, readonly) NSUInteger month;
@property (nonatomic, assign, readonly) NSUInteger day;
@property (nonatomic, assign, readonly) NSUInteger hour;
@property (nonatomic, assign, readonly) NSUInteger minute;
@property (nonatomic, assign, readonly) NSUInteger second;
/// 时期几，整数
@property (nonatomic, assign, readonly) NSUInteger weekday;
/// 当前月份的天数
@property (nonatomic, assign, readonly) NSUInteger dayInMonth;
/// 是不是闰年
@property (nonatomic, assign, readonly) BOOL isLeapYear;

#pragma mark - 日期格式化
/// YYYY年MM月dd日
- (NSString *)formatYMD;
/// 自定义分隔符
- (NSString *)formatYMDWithSeparate:(NSString *)separate;
/// MM月dd日
- (NSString *)formatMD;
/// 自定义分隔符
- (NSString *)formatMDWithSeparate:(NSString *)separate;
/// HH:MM:SS
- (NSString *)formatHMS;
/// HH:MM
- (NSString *)formatHM;
/// 星期几
- (NSString *)formatWeekday;
/// 月份
- (NSString *)formatMonth;

@end
