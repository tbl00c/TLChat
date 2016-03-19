//
//  TLChatTableViewController+Delegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatTableViewController.h"
#import "TLTextMessageCell.h"
#import "TLImageMessageCell.h"
#import "TLExpressionMessageCell.h"

@interface TLChatTableViewController (Delegate) <TLMessageCellDelegate, UIActionSheetDelegate>

- (void)registerCellClass;

@end
