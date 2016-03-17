//
//  TLEmojiKeyboard+CollectionViewDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard.h"

#define     HEIGHT_TOP_SPACE            10
#define     HEIGHT_EMOJIVIEW            (HEIGHT_CHAT_KEYBOARD * 0.75 - HEIGHT_TOP_SPACE)
#define     HEIGHT_PAGECONTROL          HEIGHT_CHAT_KEYBOARD * 0.1
#define     HEIGHT_GROUPCONTROL         HEIGHT_CHAT_KEYBOARD * 0.17

@interface TLEmojiKeyboard (CollectionViewDelegate) <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (void)resetCollectionSize;

@end
