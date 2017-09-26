//
//  TLMenuItem.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLMenuItem : NSObject

/**
 * 左侧图标路径
 */
@property (nonatomic, strong) NSString *iconName;

/**
 * 网络icon
 */
@property (nonatomic, strong) NSString *iconURL;

/**
 * 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 * 副标题
 */
@property (nonatomic, strong) NSString *subTitle;

/**
 * 右侧图片URL
 */
@property (nonatomic, strong) NSString *rightIconURL;

@property (nonatomic, strong) NSString *badge;

@property (nonatomic, assign, readonly) CGSize badgeSize;


@end

TLMenuItem *createMenuItem(NSString *icon, NSString *title);
