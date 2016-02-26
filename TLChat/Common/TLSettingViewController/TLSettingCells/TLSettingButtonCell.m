//
//  TLSettingButtonCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingButtonCell.h"

@implementation TLSettingButtonCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}

- (void) setItem:(TLSettingItem *)item
{
    _item = item;
    [self.textLabel setText:item.title];
}

@end
