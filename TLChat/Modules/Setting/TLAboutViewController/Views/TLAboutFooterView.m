//
//  TLAboutFooterView.m
//  TLChat
//
//  Created by 李伯坤 on 2018/3/5.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLAboutFooterView.h"

@implementation TLAboutFooterView

+ (CGFloat)viewHeightByDataModel:(NSNumber *)dataModel
{
    return dataModel.doubleValue;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.addLabel(1).numberOfLines(0).textAlignment(NSTextAlignmentCenter)
        .text(@"高仿微信 仅供学习\nhttps://github.com/tbl00c/TLChat")
        .font([UIFont systemFontOfSize:12.0f]).textColor([UIColor grayColor])
        .masonry(^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
            make.width.mas_lessThanOrEqualTo(self).mas_offset(-30);
        });
    }
    return self;
}

@end
