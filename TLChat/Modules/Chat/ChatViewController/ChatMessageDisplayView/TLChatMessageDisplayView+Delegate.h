//
//  TLChatMessageDisplayView+Delegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatMessageDisplayView.h"
#import "TLTextMessageCell.h"
#import "TLImageMessageCell.h"
#import "TLExpressionMessageCell.h"
#import "TLVoiceMessageCell.h"

@interface TLChatMessageDisplayView (Delegate) <UITableViewDelegate, UITableViewDataSource, TLMessageCellDelegate, TLActionSheetDelegate>

- (void)registerCellClassForTableView:(UITableView *)tableView;

@end
