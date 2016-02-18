//
//  TLChatMoreKeyboardItem.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLChatMoreKeyboardItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *imagePath;

+ (TLChatMoreKeyboardItem *)createByTitle:(NSString *)title imagePath:(NSString *)imagePath;

@end
