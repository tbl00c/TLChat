//
//  TLContactCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"
#import "TLContact.h"

/**
 *  通讯录 Cell
 */

@interface TLContactCell : TLTableViewCell

@property (nonatomic, strong) TLContact *contact;

@end
