//
//  TLExpressionCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"
#import "TLEmojiGroup.h"

@protocol TLExpressionCellDelegate <NSObject>

- (void)expressionCellDownloadButtonDown:(TLEmojiGroup *)group;

@end

@interface TLExpressionCell : TLTableViewCell

@property (nonatomic, assign) id<TLExpressionCellDelegate> delegate;

@property (nonatomic, strong) TLEmojiGroup *group;

@end
