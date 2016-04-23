//
//  TLInfoHeaderFooterView.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLInfoHeaderFooterView.h"

@implementation TLInfoHeaderFooterView

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor colorGrayBG]];
    }
    return self;
}

@end
