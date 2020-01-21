//
//  TLMomentExtension.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtension.h"
#import <YYText.h>

#define     EDGE_MOMENT_EXTENSION       5.0f

@implementation TLMomentExtension

- (id)init
{
    if (self = [super init]) {
        [TLMomentExtension mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"likedFriends" : @"TLUser",
                      @"comments" : @"TLMomentComment"};
        }];
    }
    return self;
}

- (void)setLikedFriends:(NSArray *)likedFriends
{
    _likedFriends = likedFriends;
    _attrLikedFriendsName = nil;
    
    if (likedFriends.count > 0 ) {
        UIFont *font = [UIFont systemFontOfSize:14];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
        
        // like icon
        UIImage *likeImage = [UIImage imageNamed:@"moments_like"];
        NSAttributedString *attrLikeImage = [NSAttributedString yy_attachmentStringWithContent:likeImage contentMode:UIViewContentModeCenter attachmentSize:likeImage.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [attrStr appendAttributedString:attrLikeImage];
        
        // like space
        UIView *sapce = UIView.zz_create(1).frame(CGRectMake(0, 0, 5, 14)).view;
        NSAttributedString *attrSpace = [NSAttributedString yy_attachmentStringWithContent:sapce contentMode:UIViewContentModeCenter attachmentSize:sapce.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [attrStr appendAttributedString:attrSpace];
        
        // 用户名
        @weakify(self);
        for (TLUser *user in likedFriends) {
            NSAttributedString *(^createAttrButtonWithUser)(TLUser *user, void (^eventAction)(TLUser *user)) = ^NSAttributedString *(TLUser *user, void (^eventAction)(TLUser *user)) {
                UIButton *button = UIButton.zz_create(0)
                .title(user.showName).titleFont([UIFont boldSystemFontOfSize:14]).titleColor([UIColor colorBlueMoment])
                .backgroundColor([UIColor clearColor]).backgroundColorHL([UIColor lightGrayColor])
                .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
                    if (eventAction) {
                        eventAction(user);
                    }
                })
                .view;
                [button sizeToFit];
                [button setHeight:20];
                NSAttributedString *attrButton = [NSAttributedString yy_attachmentStringWithContent:button
                                                                                        contentMode:UIViewContentModeCenter
                                                                                     attachmentSize:button.size
                                                                                        alignToFont:[UIFont systemFontOfSize:14]
                                                                                          alignment:YYTextVerticalAlignmentCenter];
                return attrButton;
            };
            
            NSAttributedString *attrUser = createAttrButtonWithUser(user, ^(TLUser *user) {
                @strongify(self);
                if (self.likeUserClickAction) {
                    self.likeUserClickAction(user);
                }
            });
            [attrStr appendAttributedString:attrUser];
            
            if (user != likedFriends.lastObject) {
                UILabel *label = UILabel.zz_create(1).frame(CGRectMake(0, 0, 11, 14)).text(@",").font([UIFont systemFontOfSize:14]).textColor([UIColor blackColor]).view;
                NSAttributedString *attrLabel = [NSAttributedString yy_attachmentStringWithContent:label contentMode:UIViewContentModeCenter attachmentSize:label.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
                [attrStr appendAttributedString:attrLabel];
            }
        }
        
        _attrLikedFriendsName = attrStr;
    }
}

#pragma mark - # Private Methods
- (CGFloat)heightLiked
{
    CGFloat height = 0.0f;
    if (self.likedFriends.count > 0) {
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(SCREEN_WIDTH - 96, MAXFLOAT) text:self.attrLikedFriendsName];
        height = layout.textBoundingSize.height + 10;
    }
    return height;
}

- (CGFloat)heightComments
{
    CGFloat height = 0.0f;
    for (TLMomentComment *comment in self.comments) {
        height += comment.commentFrame.height;
    }
    return height;
}

#pragma mark - # Getter
- (TLMomentExtensionFrame *)extensionFrame
{
    if (_extensionFrame == nil) {
        _extensionFrame = [[TLMomentExtensionFrame alloc] init];
        _extensionFrame.height = 0.0f;
        if (self.likedFriends.count > 0 || self.comments.count > 0) {
            _extensionFrame.height += EDGE_MOMENT_EXTENSION;
        }
        _extensionFrame.height += _extensionFrame.heightLiked = [self heightLiked];
        _extensionFrame.height += _extensionFrame.heightComments = [self heightComments];
    }
    return _extensionFrame;
}

@end


@implementation TLMomentExtensionFrame

@end
