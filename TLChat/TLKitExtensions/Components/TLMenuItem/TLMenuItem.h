//
//  TLMenuItem.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

#define     CELL_MENU_ITEM     @"TLMenuItemCell"

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
 * 左侧气泡
 */
@property (nonatomic, strong) NSString *badge;

/**
 * 副标题
 */
@property (nonatomic, strong) NSString *subTitle;

/**
 * 右侧图片URL
 */
@property (nonatomic, strong) NSString *rightIconURL;
/**
 * 右侧图片红点
 */
@property (nonatomic, assign) BOOL showRightIconBadge;
- (void)setRightIconURL:(NSString *)rightIconURL withRightIconBadge:(BOOL)rightIconBadge;


@property (nonatomic, assign, readonly) CGSize badgeSize;


@end

TLMenuItem *createMenuItem(NSString *icon, NSString *title);
