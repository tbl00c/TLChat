//
//  TLMomentComment.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentComment.h"
#import <YYText.h>
#import "TLUserHelper.h"

@implementation TLMomentComment
@synthesize attrContent = _attrContent;

- (id)init
{
    if (self = [super init]) {
        [TLMomentComment mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"user" : @"TLUser",
                      @"toUser" : @"TLUser"};
        }];
    }
    return self;
}

- (NSAttributedString *)attrContent
{
    if (!_attrContent) {
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
        
        NSAttributedString *(^createAttrStr)(NSString *str) = ^NSAttributedString *(NSString *str) {
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                                                                      NSFontAttributeName : [UIFont systemFontOfSize:14],
                                                                                                      }];
            return attrStr;
        };
        
        @weakify(self);
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
        if (self.user && !(self.toUser && [self.toUser.userID isEqualToString:self.user.userID])) {
            NSAttributedString *attrFrom = createAttrButtonWithUser(self.user, ^(TLUser *user) {
                @strongify(self);
                if (self.userClickAction) {
                    self.userClickAction(user);
                }
            });
            [attrStr appendAttributedString:attrFrom];
            
            if (self.toUser) {
                [attrStr appendAttributedString:createAttrStr(@"回复")];
                NSAttributedString *attrTo = createAttrButtonWithUser(self.toUser, ^(TLUser *user) {
                    @strongify(self);
                    if (self.userClickAction) {
                        self.userClickAction(user);
                    }
                });
                [attrStr appendAttributedString:attrTo];
            }
        }
        [attrStr appendAttributedString:createAttrStr([NSString stringWithFormat:@": %@", self.content])];
        
        _attrContent = attrStr;
    }
    return _attrContent;
}

#pragma mark - # Getter
- (TLMomentCommentFrame *)commentFrame
{
    if (_commentFrame == nil) {
        _commentFrame = [[TLMomentCommentFrame alloc] init];
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(SCREEN_WIDTH - 96, MAXFLOAT) text:self.attrContent];
        _commentFrame.height = layout.textBoundingSize.height + 2;
    }
    return _commentFrame;
}

@end



@implementation TLMomentCommentFrame

@end
