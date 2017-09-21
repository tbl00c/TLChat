//
//  TLExpressionDetailViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"
#import "TLImageExpressionDisplayView.h"
#import "TLEmojiGroup.h"

@interface TLExpressionDetailViewController : TLViewController

@property (nonatomic, strong) TLEmojiGroup *group;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) TLImageExpressionDisplayView *emojiDisplayView;

@end
