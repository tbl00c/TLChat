//
//  TLUserDetailNormalKVCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLUserDetailNormalKVCell.h"

@interface TLUserDetailNormalKVCell ()

@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation TLUserDetailNormalKVCell

- (void)setViewDataModel:(TLUserDetailKVModel *)dataModel
{
    [super setViewDataModel:dataModel];
    
    [self.detailLabel setText:dataModel.data];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.detailLabel = self.detailContentView.addLabel(1001)
        .font([UIFont systemFontOfSize:16])
        .masonry(^ (MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
