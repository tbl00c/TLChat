//
//  TLChatBaseViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLChatBaseViewController : UIViewController

/// 聊天数据
@property (nonatomic, strong) NSMutableArray *data;

/**
 *  设置“更多”键盘元素
 */
- (void) setChatMoreKeyboardData:(NSMutableArray *)chatMoreKeyboardData;

@end
