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
#define     WIDTH_SENDBUTTON            52

@interface TLEmojiGroupControl () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation TLEmojiGroupControl

- (id) init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.addButton];
        [self addSubview:self.collectionView];
        [self addSubview:self.sendButton];
        [self p_addMasonry];
        
        [self.collectionView registerClass:[TLEmojiGroupCell class] forCellWithReuseIdentifier:@"TLEmojiGroupCell"];
        [self selectGroupIndex:0];
    }
    return self;
}

- (void)setEmojiGroupData:(NSMutableArray *)emojiGroupData
{
    _emojiGroupData = emojiGroupData;
    [self.collectionView reloadData];
    if (emojiGroupData && emojiGroupData.count > 0) {
        [self selectGroupIndex:0];
    }
}

- (void)selectGroupIndex:(NSUInteger)groupIndex
{
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:groupIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    if (_delegate && [_delegate respondsToSelector:@selector(emojiGroupControl:didSelectedGroup:)]) {
        [_delegate emojiGroupControl:self didSelectedGroup:self.emojiGroupData[groupIndex]];
    }
}

#pragma mark - Delegate -
//MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojiGroupData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLEmojiGroup *group = self.emojiGroupData[indexPath.row];
    TLEmojiGroupCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiGroupCell" forIndexPath:indexPath];
    [cell setEmojiGroup:group];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH_EMOJIGROUP_CELL, self.height);
}

//MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(emojiGroupControl:didSelectedGroup:)]) {
        [_delegate emojiGroupControl:self didSelectedGroup:self.emojiGroupData[indexPath.row]];
    }
}

#pragma mark - Private Methods -
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

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorChatBoxLine].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, WIDTH_EMOJIGROUP_CELL, 5);
    CGContextAddLineToPoint(context, WIDTH_EMOJIGROUP_CELL, self.height - 5);
    CGContextStrokePath(context);
}

#pragma mark - Event Response -
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

#pragma mark - Getter -
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
        [_collectionView setPagingEnabled:YES];
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
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:[UIColor colorChatEmojiSend]];
        [_sendButton addTarget:self action:@selector(sendButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

@end
