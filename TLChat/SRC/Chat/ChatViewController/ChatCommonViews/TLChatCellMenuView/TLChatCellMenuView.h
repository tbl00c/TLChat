//
//  TLChatCellMenuView.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/16.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLChatMenuItemType) {
    TLChatMenuItemTypeCancel,
    TLChatMenuItemTypeCopy,
    TLChatMenuItemTypeDelete,
};

@interface TLChatCellMenuView : UIView

@property (nonatomic, assign, readonly) BOOL isShow;

@property (nonatomic, assign) TLMessageType messageType;

@property (nonatomic, copy) void (^actionBlcok)();

+ (TLChatCellMenuView *)sharedMenuView;

- (void)showInView:(UIView *)view withMessageType:(TLMessageType)messageType rect:(CGRect)rect actionBlock:(void (^)(TLChatMenuItemType))actionBlock;

- (void)dismiss;

@end
