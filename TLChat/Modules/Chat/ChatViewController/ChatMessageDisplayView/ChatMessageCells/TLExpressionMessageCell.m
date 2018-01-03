//
//  TLExpressionMessageCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionMessageCell.h"
#import <SDWebImage/UIImage+GIF.h>
#import "NSFileManager+TLChat.h"

@interface TLExpressionMessageCell ()

@property (nonatomic, strong) UIImageView *msgImageView;

@end

@implementation TLExpressionMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgImageView];
    }
    return self;
}

- (void)setMessage:(TLExpressionMessage *)message
{
    [self.msgImageView setAlpha:1.0];       // 取消长按效果
//    if (self.message && [self.message.messageID isEqualToString:message.messageID]) {
//        return;
//    }
    TLMessageOwnerType lastOwnType = self.message ? self.message.ownerTyper : -1;
    [super setMessage:message];
    
    NSData *data = [NSData dataWithContentsOfFile:message.path];
    if (data) {
        [self.msgImageView setImage:[UIImage imageNamed:message.path]];
        [self.msgImageView setImage:[UIImage sd_animatedGIFWithData:data]];
    }
    else {      // 表情组被删掉，先从缓存目录中查找，没有的话在下载并存入缓存目录
        NSString *cachePath = [NSFileManager cacheForFile:[NSString stringWithFormat:@"%@_%@.gif", message.emoji.gid, message.emoji.eId]];
        NSData *data = [NSData dataWithContentsOfFile:cachePath];
        if (data) {
            [self.msgImageView setImage:[UIImage imageNamed:cachePath]];
            [self.msgImageView setImage:[UIImage sd_animatedGIFWithData:data]];
        }
        else {
            __weak typeof(self) weakSelf = self;
            [self.msgImageView tt_setImageWithURL:TLURL(message.url) completed:^(UIImage *image, NSError *error, TLImageCacheType cacheType, NSURL *imageURL) {
                if ([[imageURL description] isEqualToString:[(TLExpressionMessage *)weakSelf.message url]]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData *data = [NSData dataWithContentsOfURL:imageURL];
                        [data writeToFile:cachePath atomically:NO];      // 再写入到缓存中
                        if ([[imageURL description] isEqualToString:[(TLExpressionMessage *)weakSelf.message url]]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.msgImageView setImage:[UIImage sd_animatedGIFWithData:data]];
                            });
                        }
                    });
                }
            }];
        }
    }
    
    if (lastOwnType != message.ownerTyper) {
        if (message.ownerTyper == TLMessageOwnerTypeSelf) {
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(5);
                make.right.mas_equalTo(self.messageBackgroundView).mas_offset(-10);
            }];
        }
        else if (message.ownerTyper == TLMessageOwnerTypeFriend){
            [self.msgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(5);
                make.left.mas_equalTo(self.messageBackgroundView).mas_offset(10);
            }];
        }
    }
    [self.msgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(message.messageFrame.contentSize);
    }];
}

#pragma mark - Event Response -
- (void)longPressMsgBGView:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    [self.msgImageView setAlpha:0.7];   // 比较low的选中效果
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellLongPress:rect:)]) {
        CGRect rect = self.msgImageView.frame;
        [self.delegate messageCellLongPress:self.message rect:rect];
    }
}

- (void)doubleTabpMsgBGView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellDoubleClick:)]) {
        [self.delegate messageCellDoubleClick:self.message];
    }
}

#pragma mark - Getter -
- (UIImageView *)msgImageView
{
    if (_msgImageView == nil) {
        _msgImageView = [[UIImageView alloc] init];
        [_msgImageView setUserInteractionEnabled:YES];
        
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMsgBGView:)];
        [_msgImageView addGestureRecognizer:longPressGR];
        
        UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTabpMsgBGView)];
        [doubleTapGR setNumberOfTapsRequired:2];
        [_msgImageView addGestureRecognizer:doubleTapGR];
    }
    return _msgImageView;
}

@end
