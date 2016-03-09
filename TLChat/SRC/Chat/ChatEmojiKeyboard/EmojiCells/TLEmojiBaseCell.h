//
//  TLEmojiBaseCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLEmojiKeyboardDelegate.h"
#import "TLEmoji.h"

@interface TLEmojiBaseCell : UICollectionViewCell

@property (nonatomic, assign) id<TLEmojiKeyboardDelegate>delegate;

@property (nonatomic, strong) TLEmoji *emojiItem;

@property (nonatomic, strong) UIButton *bgView;

@end
