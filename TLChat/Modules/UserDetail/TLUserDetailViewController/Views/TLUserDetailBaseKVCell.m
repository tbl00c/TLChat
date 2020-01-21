//
//  TLUserDetailBaseKVCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLUserDetailBaseKVCell.h"

TLUserDetailKVModel *createUserDetailKVModel(NSString *title, id data)
{
    TLUserDetailKVModel *model = [[TLUserDetailKVModel alloc] init];
    model.title = title;
    model.data = data;
    return model;
}

@interface TLUserDetailBaseKVCell ()

@property (nonatomic, strong) UIView *arrowView;

@end

@implementation TLUserDetailBaseKVCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 44.0f;
}

- (void)setViewDataModel:(TLUserDetailKVModel *)dataModel
{
    [self.titleLabel setText:dataModel.title];
    [self.arrowView setHidden:dataModel.hiddenArrow];
    [self setSelectedBackgrounColor:dataModel.selectable ? [UIColor colorGrayLine] : nil];
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
        
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont systemFontOfSize:16])
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(80);
        })
        .view;
        
        self.arrowView = self.contentView.addImageView(2)
        .image([UIImage imageNamed:@"right_arrow"])
        .masonry(^ (MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(8, 13));
            make.right.mas_equalTo(-15);
        })
        .view;
        
        self.detailContentView = self.contentView.addView(3)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right);
            make.right.mas_equalTo(self.arrowView.mas_left);
            make.top.bottom.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end

@implementation TLUserDetailKVModel

- (instancetype)init
{
    if (self = [super init]) {
        self.selectable = YES;
    }
    return self;
}

@end
