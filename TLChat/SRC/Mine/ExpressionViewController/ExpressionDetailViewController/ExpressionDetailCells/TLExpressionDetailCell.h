//
//  TLExpressionDetailCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLEmojiGroup.h"

#define         HEIGHT_EXP_BANNER       (WIDTH_SCREEN * 0.45)

@protocol TLExpressionDetailCellDelegate <NSObject>

- (void)expressionDetailCellDownloadButtonDown:(TLEmojiGroup *)group;

@end

@interface TLExpressionDetailCell : UICollectionViewCell

@property (nonatomic, assign) id <TLExpressionDetailCellDelegate> delegate;

@property (nonatomic, strong) TLEmojiGroup *group;

+ (CGFloat)cellHeightForModel:(TLEmojiGroup *)group;

@end
