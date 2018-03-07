//
//  TLMyExpressionCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/12.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMyExpressionCell.h"
#import "UIImage+Color.h"

@interface TLMyExpressionCell()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLMyExpressionCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 50;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setGroup:dataModel];
}

- (void)setViewDelegate:(id)delegate
{
    self.delegate = delegate;
}

#pragma mark - # Cell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.arrowView setHidden:YES];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        
        [self p_initMyExpressionCellSubviews];
    }
    return self;
}

- (void)setGroup:(TLExpressionGroupModel *)group
{
    _group = group;
    [self.iconView setImage:[UIImage imageNamed:group.iconPath]];
    [self.titleLabel setText:group.name];
}

#pragma mark - # UI
- (void)p_initMyExpressionCellSubviews
{
    @weakify(self);
    
    self.iconView = self.contentView.addImageView(1)
    .masonry(^ (MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0f);
        make.centerY.mas_equalTo(0);
        make.width.and.height.mas_equalTo(35);
    })
    .view;
    
    UIButton *deleteButton = self.contentView.addButton(2)
    .backgroundColor([UIColor colorGrayBG]).backgroundColorHL([UIColor colorGrayLine])
    .title(LOCSTR(@"移除")).titleColor([UIColor grayColor]).titleFont([UIFont systemFontOfSize:13.0f])
    .cornerRadius(3.0f).border(BORDER_WIDTH_1PX, [UIColor colorGrayLine])
    .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
        @strongify(self);
        if (self.delegate && [self.delegate respondsToSelector:@selector(myExpressionCellDeleteButtonDown:)]) {
            [self.delegate myExpressionCellDeleteButtonDown:self.group];
        }
    })
    .masonry(^ (MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    })
    .view;
    
    self.titleLabel = self.addLabel(3)
    .masonry(^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(10.0f);
        make.right.mas_lessThanOrEqualTo(deleteButton.mas_left).mas_offset(-15.0f);
    })
    .view;
}

@end
