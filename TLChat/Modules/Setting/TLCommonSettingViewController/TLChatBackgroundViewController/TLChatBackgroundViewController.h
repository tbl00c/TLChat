//
//  TLChatBackgroundViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLChatBackgroundViewController : ZZFlexibleLayoutViewController

/**
 *  若为nil则全局设置，否则只给对应好友设置
 */
@property (nonatomic, strong) NSString *partnerID;

@end
