//
//  TLMoreKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLKeyboardDelegate.h"
#import "TLMoreKeyboardDelegate.h"
#import "TLMoreKeyboardItem.h"

@interface TLMoreKeyboard : UIView

@property (nonatomic, assign) id<TLKeyboardDelegate> keyboardDelegate;

@property (nonatomic, assign) id<TLMoreKeyboardDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *chatMoreKeyboardData;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

+ (TLMoreKeyboard *)keyboard;

- (void)reset;

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

- (void)dismissWithAnimation:(BOOL)animation;

@end
