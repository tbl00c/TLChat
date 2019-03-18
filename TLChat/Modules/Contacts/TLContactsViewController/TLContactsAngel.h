//
//  TLContactsAngel.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/8.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLContactsVCSectionType) {
    TLContactsVCSectionTypeFuncation = -1,
    TLContactsVCSectionTypeEnterprise = -2,
};

typedef NS_ENUM(NSInteger, TLContactsVCCellType) {
    TLContactsVCCellTypeNew = -1,
    TLContactsVCCellTypeGroup = -2,
    TLContactsVCCellTypeTag = -3,
    TLContactsVCCellTypePublic = -4,
};

@interface TLContactsAngel : ZZFLEXAngel

/// pushAction
@property (nonatomic, copy) void (^pushAction)(__kindof UIViewController *vc);

- (void)resetListWithContactsData:(NSArray *)contactsData sectionHeaders:(NSArray *)sectionHeaders;

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView pushAction:(void (^)(__kindof UIViewController *vc))pushAction;

@end
