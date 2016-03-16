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

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)showInView:(UIView *)view withMessageType:(TLMessageType)messageType rect:(CGRect)rect actionBlock:(void (^)(TLChatMenuItemType))actionBlock
{
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
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(clickedMenuItem:)];
    UIMenuItem *transmit = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(clickedMenuItem:)];
    UIMenuItem *collect = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(clickedMenuItem:)];
    [self.menuController setMenuItems:@[copy, transmit, collect]];
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
- (void)clickedMenuItem:(UIMenuController *)sender
{
    _isShow = NO;
    [self removeFromSuperview];
    if (self.actionBlcok) {
        self.actionBlcok(TLChatMenuItemTypeCopy);
    }
}

#pragma mark - Getter -
- (UIMenuController *)menuController
{
    if (_menuController == nil) {
        _menuController = [[UIMenuController alloc] init];
    }
    return _menuController;
}

@end
