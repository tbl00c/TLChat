//
//  TLAddMenuView.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAddMenuItem.h"

@class TLAddMenuView;
@protocol TLAddMenuViewDelegate <NSObject>

- (void)addMenuView:(TLAddMenuView *)addMenuView didSelectedItem:(TLAddMenuItem *)item;

@end

@interface TLAddMenuView : UIView

@property (nonatomic, assign) id<TLAddMenuViewDelegate>delegate;

- (void)showInView:(UIView *)view;

- (BOOL)isShow;

- (void)dismiss;

@end
