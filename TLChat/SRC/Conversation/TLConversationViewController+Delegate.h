//
//  TLConversationViewController+Delegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationViewController.h"
#import "TLChatViewController.h"
#import "TLAddMenuView.h"

#define     HEIGHT_CONVERSATION_CELL        65.0f

@interface TLConversationViewController (Delegate) <UISearchBarDelegate, TLAddMenuViewDelegate>

- (void)registerCellClass;

@end
