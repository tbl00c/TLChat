//
//  TLExpressionDetailViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"
#import "TLImageExpressionDisplayView.h"
#import "TLExpressionGroupModel.h"

@interface TLExpressionDetailViewController : TLViewController

@property (nonatomic, strong) TLExpressionGroupModel *group;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) TLImageExpressionDisplayView *emojiDisplayView;

@end
