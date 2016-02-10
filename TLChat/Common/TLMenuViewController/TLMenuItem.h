//
//  TLMenuItem.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

#define     TLCreateMenuItem(IconPath, Title) [TLMenuItem createMenuWithIconPath:IconPath title:Title]

@interface TLMenuItem : NSObject

/**
 *  左侧图标路径
 */
@property (nonatomic, strong) NSString *iconPath;

/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;

/**
 *  副标题
 */
@property (nonatomic, strong) NSString *subTitle;

/**
 *  副图片URL
 */
@property (nonatomic, strong) NSString *rightIconURL;

/**
 *  是否显示红点
 */
@property (nonatomic, assign) BOOL showRightRedPoint;

+ (TLMenuItem *) createMenuWithIconPath:(NSString *)iconPath title:(NSString *)title;

@end
