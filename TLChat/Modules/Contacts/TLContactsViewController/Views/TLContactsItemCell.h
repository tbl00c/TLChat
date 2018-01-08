//
//  TLContactsItemCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLUser.h"

@class TLContactsItemModel;
TLContactsItemModel *createContactsItemModel(NSString *path, NSString *url, NSString *title, NSString *subTitle, id userInfo);
TLContactsItemModel *createContactsItemModelWithTag(NSInteger tag, NSString *path, NSString *url, NSString *title, NSString *subTitle, id userInfo);

@interface TLContactsItemModel : NSObject

/// tag
@property (nonatomic, assign) NSInteger tag;

/// 图片本地路径
@property (nonatomic, strong) NSString *imagePath;

/// 图片url，优先使用
@property (nonatomic, strong) NSString *imageUrl;

/// 标题
@property (nonatomic, strong) NSString *title;

/// 副标题
@property (nonatomic, strong) NSString *subTitle;

/// 占位图
@property (nonatomic, strong) UIImage *placeholderImage;

/// 用户自定义数据
@property (nonatomic, strong) id userInfo;

@end

@interface TLContactsItemCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLContactsItemModel *model;

@end
