//
//  TLInfoButtonCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"
#import "TLInfo.h"

@protocol TLInfoButtonCellDelegate <NSObject>

- (void)infoButtonCellClicked:(TLInfo *)info;

@end

@interface TLInfoButtonCell : TLTableViewCell

@property (nonatomic, assign) id<TLInfoButtonCellDelegate>delegate;

@property (nonatomic, strong) TLInfo *info;

@end
