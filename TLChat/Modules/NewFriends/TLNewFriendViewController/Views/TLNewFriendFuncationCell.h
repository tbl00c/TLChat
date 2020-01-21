//
//  TLNewFriendFuncationCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLNewFriendFuncationModel;
TLNewFriendFuncationModel *createNewFriendFuncationModel(NSString *icon, NSString *title);

@interface TLNewFriendFuncationModel : NSObject

/// 图片
@property (nonatomic, strong) NSString *iconPath;

/// 标题
@property (nonatomic, strong) NSString *title;

@end

@interface TLNewFriendFuncationCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

/// 模型
@property (nonatomic, strong) TLNewFriendFuncationModel *model;

@end
