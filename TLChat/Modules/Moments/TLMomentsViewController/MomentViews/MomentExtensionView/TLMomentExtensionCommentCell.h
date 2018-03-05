//
//  TLMomentExtensionCommentCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMomentComment.h"

typedef NS_ENUM(NSInteger, TLMECommentCellEventType) {
    TLMECommentCellEventTypeUserClick,
};

@interface TLMomentExtensionCommentCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, copy) id (^eventAction)(TLMECommentCellEventType, id);

@end
