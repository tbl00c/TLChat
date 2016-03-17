//
//  TLTagCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTagCell.h"

@implementation TLTagCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftSeparatorSpace = 15;
        [self.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    return self;
}

@end
