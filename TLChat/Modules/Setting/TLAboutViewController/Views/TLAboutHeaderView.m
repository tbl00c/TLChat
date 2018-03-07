//
//  TLAboutHeaderView.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAboutHeaderView.h"

@interface TLAboutHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLAboutHeaderView

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 120.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setText:dataModel];
}

#pragma mark - # View
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = self.addLabel(1000)
        .font([UIFont systemFontOfSize:17.0f]).textColor([UIColor grayColor])
        .masonry(^ (MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(self).mas_offset(-30);
            make.bottom.mas_equalTo(-13);
        })
        .view;
        
        self.addImageView(1001).image(TLImage(@"AppLogo"))
        .masonry(^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(73, 64));
        });
    }
    return self;
}

@end
