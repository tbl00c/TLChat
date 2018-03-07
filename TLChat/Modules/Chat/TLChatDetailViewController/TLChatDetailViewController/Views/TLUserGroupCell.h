//
//  TLUserGroupCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLUserGroupCellEventType) {
    TLUserGroupCellEventTypeAdd,
    TLUserGroupCellEventTypeClickUser,
};

@interface TLUserGroupCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, copy) id (^eventAction)(TLUserGroupCellEventType eventType, id data);

@property (nonatomic, strong) NSMutableArray *users;


@end
