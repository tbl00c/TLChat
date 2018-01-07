//
//  TLUserDetailViewChatButtonCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLUserDetailViewChatButtonCell.h"

@implementation TLUserDetailViewChatButtonCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.button.zz_make.backgroundColor([UIColor whiteColor]).titleColor([UIColor blackColor])
        .backgroundColorHL([UIColor lightGrayColor]).titleColorHL([[UIColor blackColor] colorWithAlphaComponent:0.7]);
    }
    return self;
}

@end
