//
//  TLSettingItem.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLSettingItem : NSObject

#define     TLCreateSettingItem(title) [TLSettingItem createItemWithTitle:title]

typedef NS_ENUM(NSInteger, TLSettingItemType) {
    TLSettingItemTypeDefalut = 0,
    TLSettingItemTypeTitleButton,
    TLSettingItemTypeSwitch,
};

@property (nonatomic, strong) NSString *title;

/**
 *  cell类型，默认default
 */
@property (nonatomic, assign) TLSettingItemType type;

+ (TLSettingItem *) createItemWithTitle:(NSString *)title;

- (NSString *) cellClassName;

@end
