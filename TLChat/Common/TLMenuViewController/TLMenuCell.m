//
//  TLMenuCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMenuCell.h"

@implementation TLMenuCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void) setMenuItem:(TLMenuItem *)menuItem
{
    _menuItem = menuItem;
    [self.imageView setImage:[UIImage imageNamed:menuItem.iconPath]];
    [self.textLabel setText:menuItem.title];
}

@end
