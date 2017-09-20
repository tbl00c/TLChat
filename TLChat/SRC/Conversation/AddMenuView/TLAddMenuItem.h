//
//  TLAddMenuItem.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TLAddMneuType) {
    TLAddMneuTypeGroupChat = 0,
    TLAddMneuTypeAddFriend,
    TLAddMneuTypeScan,
    TLAddMneuTypeWallet,
};

@interface TLAddMenuItem : NSObject

@property (nonatomic, assign) TLAddMneuType type;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *iconPath;

@property (nonatomic, strong) NSString *className;

+ (TLAddMenuItem *)createWithType:(TLAddMneuType)type title:(NSString *)title iconPath:(NSString *)iconPath className:(NSString *)className;

@end
