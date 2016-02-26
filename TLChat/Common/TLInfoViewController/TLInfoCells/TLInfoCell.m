//
//  TLInfoCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLInfoCell.h"

@implementation TLInfoCell

- (void)setInfo:(TLInfo *)info
{
    _info = info;
    [self.textLabel setText:info.title];
}

@end
