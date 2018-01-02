//
//  TLEmojiGroupControl.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiGroupControl.h"
#import "TLEmojiGroupCell.h"

#define     WIDTH_EMOJIGROUP_CELL       46
#define     WIDTH_SENDBUTTON            60

@interface TLEmojiGroupControl () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSIndexPath *curIndexPath;

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation TLEmojiGroupControl

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.addButton];
        [self addSubview:self.collectionView];
        [self addSubview:self.sendButton];
        [self p_addMasonry];
        
        [self.collectionView registerClass:[TLEmojiGroupCell class] forCellWithReuseIdentifier:@"TLEmojiGroupCell"];
    }
    return self;
}

- (void)setSendButtonStatus:(TLGroupControlSendButtonStatus)sendButtonStatus
{
    if (_sendButtonStatus != sendButtonStatus) {
        if (_sendButtonStatus == TLGroupControlSendButtonStatusNone) {
            [self.sendButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self.collectionView reloadData];
                [self.collectionView selectItemAtIndexPath:self.curIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            }];
            if (sendButtonStatus == TLGroupControlSendButtonStatusBlue) {
                [_sendButton setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_blue"] forState:UIControlStateNormal];
                [_sendButton setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_blueHL"] forState:UIControlStateHighlighted];
                [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if (sendButtonStatus == TLGroupControlSendButtonStatusGray) {
                [_sendButton setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_gray"] forState:UIControlStateNormal];
                [_sendButton setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_gray"] forState:UIControlStateHighlighted];
                [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
        else if (sendButtonStatus == TLGroupControlSendButtonStatusNone) {
            [self.sendButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).mas_offset(WIDTH_SENDBUTTON);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self.collectionView reloadData];
                [self.collectionView selectItemAtIndexPath:self.curIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            }];
        }
        _sendButtonStatus = sendButtonStatus;
    }
}

- (void)setEmojiGroupData:(NSMutableArray *)emojiGroupData
{
    if (_emojiGroupData == emojiGroupData || [_emojiGroupData isEqualToArray:emojiGroupData]) {
        return;
    }
    _emojiGroupData = emojiGroupData;
    [self.collectionView reloadData];
    if (emojiGroupData && emojiGroupData.count > 0) {
        [self setCurIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
}

- (void)selectEmojiGroupAtIndex:(NSInteger)index
{
    if (index < self.emojiGroupData.count) {
        _curIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView selectItemAtIndexPath:_curIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        CGFloat width = WIDTH_EMOJIGROUP_CELL;
        CGFloat x = width * index;
        if (x < self.collectionView.contentOffset.x) {
            [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
        }
        else if (x + width > self.collectionView.contentOffset.x + self.collectionView.width) {
            [self.collectionView setContentOffset:CGPointMake(x + width - self.collectionView.width, 0) animated:YES];
        }
    }
}

- (void)setCurIndexPath:(NSIndexPath *)curIndexPath
{
    if (curIndexPath.row < self.emojiGroupData.count) {
        [self.collectionView scrollToItemAtIndexPath:curIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        [self.collectionView selectItemAtIndexPath:curIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        if (_curIndexPath && _curIndexPath.section == curIndexPath.section && _curIndexPath.row == curIndexPath.row) {
            return;
        }
        
        CGFloat width = WIDTH_EMOJIGROUP_CELL;
        CGFloat x = width * curIndexPath.row;
        if (x < self.collectionView.contentOffset.x) {
            [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
        }
        else if (x + width > self.collectionView.contentOffset.x + self.collectionView.width) {
            [self.collectionView setContentOffset:CGPointMake(x + width - self.collectionView.width, 0) animated:YES];
        }
        
        _curIndexPath = curIndexPath;
        if (_delegate && [_delegate respondsToSelector:@selector(emojiGroupControl:didSelectedGroup:)]) {
            TLExpressionGroupModel *group = [self.emojiGroupData objectAtIndex:curIndexPath.row];
            [_delegate emojiGroupControl:self didSelectedGroup:group];
        }
    }
}

#pragma mark - # Delegate
//MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojiGroupData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLEmojiGroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiGroupCell" forIndexPath:indexPath];
    TLExpressionGroupModel *group = [self.emojiGroupData objectAtIndex:indexPath.row];
    [cell setEmojiGroup:group];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH_EMOJIGROUP_CELL, self.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == self.emojiGroupData.count - 1) {
        return CGSizeMake(WIDTH_EMOJIGROUP_CELL * 2, self.height);
    }
    return CGSizeZero;
}


//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLExpressionGroupModel *group = [self.emojiGroupData objectAtIndex:indexPath.row];
    if (group.type == TLEmojiTypeOther) {
        //???: 存在冲突：用户选中cellA,再此方法中立马调用方法选中cellB时，所有cell都不会被选中
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setCurIndexPath:_curIndexPath];
        });
        [self p_eidtMyEmojiButtonDown];
    }
    else {
        [self setCurIndexPath:indexPath];
    }
}

#pragma mark - # Event Response
- (void)emojiAddButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(emojiGroupControlEditButtonDown:)]) {
        [_delegate emojiGroupControlEditButtonDown:self];
    }
}

- (void)sendButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(emojiGroupControlSendButtonDown:)]) {
        [_delegate emojiGroupControlSendButtonDown:self];
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.mas_equalTo(self);
        make.width.mas_equalTo(WIDTH_EMOJIGROUP_CELL);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.mas_equalTo(self);
        make.width.mas_equalTo(WIDTH_SENDBUTTON);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.addButton.mas_right);
        make.right.mas_equalTo(self.sendButton.mas_left);
    }];
}

- (void)p_eidtMyEmojiButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(emojiGroupControlEditMyEmojiButtonDown:)]) {
        [_delegate emojiGroupControlEditMyEmojiButtonDown:self];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorGrayLine].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, WIDTH_EMOJIGROUP_CELL, 5);
    CGContextAddLineToPoint(context, WIDTH_EMOJIGROUP_CELL, self.height - 5);
    CGContextStrokePath(context);
}

#pragma mark - # Getter
- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"emojiKB_groupControl_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(emojiAddButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [layout setMinimumLineSpacing:0];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setScrollsToTop:NO];
    }
    return _collectionView;
}

- (UIButton *)sendButton
{
    if (_sendButton == nil) {
        _sendButton = [[UIButton alloc] init];
        [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_sendButton setTitle:@"  发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:[UIColor clearColor]];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_gray"] forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_gray"] forState:UIControlStateHighlighted];
        [_sendButton addTarget:self action:@selector(sendButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

@end
