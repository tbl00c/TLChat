//
//  TLMomentExtensionLikedCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLMELikedCellEventType) {
    TLMELikedCellEventTypeClickUser,
};

@interface TLMomentExtensionLikedCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, copy) id (^eventAction)(TLMELikedCellEventType, id);

@end
