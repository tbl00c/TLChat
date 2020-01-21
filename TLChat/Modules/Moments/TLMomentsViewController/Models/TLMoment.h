//
//  TLMoment.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMomentDetail.h"
#import "TLMomentExtension.h"

@class TLMomentLinkModel;
@class TLMomentFrame;

@interface TLMoment : NSObject

@property (nonatomic, strong) NSString *momentID;

@property (nonatomic, strong) TLUser *user;

/// 发布时间
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong, readonly) NSString *showDate;

/// 来源
@property (nonatomic, strong) NSString *source;

/// 跳转链接（位置、app url等）
@property (nonatomic, strong) TLMomentLinkModel *link;

/// 详细内容
@property (nonatomic, strong) TLMomentDetail *detail;

/// 是否有赞和评论
@property (nonatomic, assign, readonly) BOOL hasExtension;
/// 附加（评论，赞）
@property (nonatomic, strong) TLMomentExtension *extension;

@property (nonatomic, strong) TLMomentFrame *momentFrame;

@end


@interface TLMomentLinkModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *jumpUrl;

@end


@interface TLMomentFrame : NSObject

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat heightDetail;

@property (nonatomic, assign) CGFloat heightExtension;

@end

