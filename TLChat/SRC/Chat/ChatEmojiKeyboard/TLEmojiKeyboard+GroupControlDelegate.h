//
//  TLEmojiKeyboard+GroupControlDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard.h"

@interface TLEmojiKeyboard (GroupControlDelegate) <TLEmojiGroupControlDelegate>

- (void)updateSendButtonStatus;

@end
