//
//  TLChatCellMenuView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/16.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatCellMenuView.h"

@interface TLChatCellMenuView ()

@property (nonatomic, strong) UIMenuController *menuController;

@end

@implementation TLChatCellMenuView

+ (TLChatCellMenuView *)sharedMenuView
{
    static TLChatCellMenuView *menuView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuView = [[TLChatCellMenuView alloc] init];
    });
    return menuView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.menuController = [UIMenuController sharedMenuController];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)showInView:(UIView *)view withMessageType:(TLMessageType)messageType rect:(CGRect)rect actionBlock:(void (^)(TLChatMenuItemType))actionBlock
{
    if (_isShow) {
        return;
    }
    _isShow = YES;
    [self setFrame:view.bounds];
    [view addSubview:self];
    [self setActionBlcok:actionBlock];
    [self setMessageType:messageType];
    
    [self.menuController setTargetRect:rect inView:self];
    [self becomeFirstResponder];
    [self.menuController setMenuVisible:YES animated:YES];
}

- (void)setMessageType:(TLMessageType)messageType
{
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyButtonDown:)];
    UIMenuItem *transmit = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(transmitButtonDown:)];
    UIMenuItem *collect = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(collectButtonDown:)];
    UIMenuItem *del = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteButtonDown:)];
    [self.menuController setMenuItems:@[copy, transmit, collect, del]];
}

- (void)dismiss
{
    _isShow = NO;
    if (self.actionBlcok) {
        self.actionBlcok(TLChatMenuItemTypeCancel);
    }
    [self.menuController setMenuVisible:NO animated:YES];
    [self removeFromSuperview];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - Event Response -
- (void)copyButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeCopy];
}

- (void)transmitButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeCopy];
}

- (void)collectButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeCopy];
}

- (void)deleteButtonDown:(UIMenuController *)sender
{
    [self p_clickedMenuItemType:TLChatMenuItemTypeDelete];
}

#pragma mark - Private Methods -
- (void)p_clickedMenuItemType:(TLChatMenuItemType)type
{
    _isShow = NO;
    [self removeFromSuperview];
    if (self.actionBlcok) {
        self.actionBlcok(type);
    }
}

@end
