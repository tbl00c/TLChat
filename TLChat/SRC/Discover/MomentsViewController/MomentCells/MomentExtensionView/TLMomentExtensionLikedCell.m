
//
//  TLMomentExtensionLikedCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionLikedCell.h"

@implementation TLMomentExtensionLikedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBottomLineStyle:TLCellLineStyleFill];
    }
    return self;
}

@end
