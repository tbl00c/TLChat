//
//  TLSettingSwitchCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingSwitchCell.h"

@interface TLSettingSwitchCell ()

@property (nonatomic, strong) UISwitch *cellSwitch;

@end

@implementation TLSettingSwitchCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryView:self.cellSwitch];
    }
    return self;
}

- (void) setItem:(TLSettingItem *)item
{
    _item = item;
    [self.textLabel setText:item.title];
}

#pragma mark - Getter
- (UISwitch *) cellSwitch
{
    if (_cellSwitch == nil) {
        _cellSwitch = [[UISwitch alloc] init];
    }
    return _cellSwitch;
}

@end
