//
//  TLUserDetailTitleCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLUserDetailTitleCell.h"

@interface TLUserDetailTitleCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLUserDetailTitleCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 44.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setText:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(ZZSeparatorPositionTop);
    }
    
    if (indexPath.row == count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        UIImageView *arrowView = self.contentView.addImageView(2)
        .image([UIImage imageNamed:@"right_arrow"])
        .masonry(^ (MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(8, 13));
            make.right.mas_equalTo(-15);
        })
        .view;
        
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont systemFontOfSize:16])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.right.mas_lessThanOrEqualTo(arrowView.mas_left).mas_offset(-15);
        })
        .view;
    }
    
    return self;
}

@end
