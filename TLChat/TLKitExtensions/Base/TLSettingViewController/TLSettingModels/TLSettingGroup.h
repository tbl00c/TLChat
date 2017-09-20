//
//  TLSettingGroup.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLSettingItem.h"

#define     TLCreateSettingGroup(Header, Footer, Items)  [TLSettingGroup createGroupWithHeaderTitle:Header footerTitle:Footer items:[NSMutableArray arrayWithArray:Items]]

@interface TLSettingGroup : NSObject

/**
 *  section头部标题
 */
@property (nonatomic, strong) NSString *headerTitle;

/**
 *  section尾部说明
 */
@property (nonatomic, strong) NSString *footerTitle;

/**
 *  setcion元素
 */
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign, readonly) CGFloat headerHeight;

@property (nonatomic, assign, readonly) CGFloat footerHeight;

@property (nonatomic, assign, readonly) NSUInteger count;

+ (TLSettingGroup *)createGroupWithHeaderTitle:(NSString *)headerTitle
                                    footerTitle:(NSString *)footerTitle
                                          items:(NSMutableArray *)items;


- (id)objectAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfObject:(id)obj;

- (void)removeObject:(id)obj;

@end
