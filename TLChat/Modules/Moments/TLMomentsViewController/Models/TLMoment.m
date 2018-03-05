//
//  TLMoment.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMoment.h"

#define     HEIGHT_MOMENT_DEFAULT       78.0f

@implementation TLMoment

- (void)setDate:(NSString *)date
{
    _date = date;
    _showDate = [self momBabayMomentPublishTimeFromInterval:date];
}

- (NSString *)momBabayMomentPublishTimeFromInterval:(NSString *)timeInterval
{
    NSTimeInterval late = [timeInterval longLongValue];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = @"";
    
    NSTimeInterval cha = now - late;  //秒
    if (cha < 60) {
        timeString = @"刚刚";
    }
    else if (cha / 3600 < 1 && cha > 60) {
        int mm = cha / 60;
        timeString = [NSString stringWithFormat:@"%d分钟前", mm];
    }
    else if (cha / 3600 >= 1 && cha/86400 < 1) {
        int hh = cha / 3600;
        timeString = [NSString stringWithFormat:@"%d小时前", hh];
    }
    else if (cha / 86400 >= 1 && cha/31536000 < 1) {
        int dd = cha / 86400;
        timeString = [NSString stringWithFormat:@"%d天前", dd];
    }
    else if (cha / 31536000 >= 1) {
        int yy = cha / 31536000;
        timeString = [NSString stringWithFormat:@"%d年前", yy];
    }
    
    return timeString;
}

#pragma mark - # Getter
- (TLMomentFrame *)momentFrame
{
    if (_momentFrame == nil) {
        _momentFrame = [[TLMomentFrame alloc] init];
        _momentFrame.height = HEIGHT_MOMENT_DEFAULT;
        _momentFrame.height += _momentFrame.heightDetail = self.detail.detailFrame.height;  // 正文高度
        if (self.hasExtension) {
            _momentFrame.height += 10;
            _momentFrame.height += _momentFrame.heightExtension = self.extension.extensionFrame.height;   // 拓展高度
        }
        if (self.link) {
            _momentFrame.height += 25;
        }
    }
    return _momentFrame;
}

- (BOOL)hasExtension
{
    BOOL hasExtension = self.extension.likedFriends.count > 0 || self.extension.comments.count > 0;
    return hasExtension;
}

@end


@implementation TLMomentFrame

@end

@implementation TLMomentLinkModel

@end
