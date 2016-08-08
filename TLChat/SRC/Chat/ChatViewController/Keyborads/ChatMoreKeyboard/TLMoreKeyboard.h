//
//  TLMoreKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseKeyboard.h"
#import "TLKeyboardDelegate.h"
#import "TLMoreKeyboardDelegate.h"
#import "TLMoreKeyboardItem.h"

@interface TLMoreKeyboard : TLBaseKeyboard

@property (nonatomic, assign) id<TLMoreKeyboardDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *chatMoreKeyboardData;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

+ (TLMoreKeyboard *)keyboard;

@end
