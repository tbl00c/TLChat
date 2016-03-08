//
//  TLAddThirdPartFriendCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"

static const NSString *TLThirdPartFriendTypeContacts = @"1";
static const NSString *TLThirdPartFriendTypeQQ = @"2";
static const NSString *TLThirdPartFriendTypeGoogle = @"3";

@protocol TLAddThirdPartFriendCellDelegate <NSObject>

- (void)addThirdPartFriendCellDidSelectedType:(NSString *)thirdPartFriendType;

@end

@interface TLAddThirdPartFriendCell : TLTableViewCell

@property (nonatomic, assign) id<TLAddThirdPartFriendCellDelegate>delegate;

/**
 *  第三方类型
 *  {
 *      TLThirdPartFriendTypeContacts
 *      TLThirdPartFriendTypeQQ
 *      TLThirdPartFriendTypeGoogle
 *  }
 */
@property (nonatomic, strong) NSArray *thridPartItems;

@end
