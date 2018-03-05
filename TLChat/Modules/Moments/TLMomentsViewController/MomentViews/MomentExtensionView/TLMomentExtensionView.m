
//
//  TLMomentExtensionView.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionView.h"
#import "TLUserDetailViewController.h"
#import "TLMomentExtensionCommentCell.h"
#import "TLMomentExtensionLikedCell.h"

#define     EDGE_HEADER     5.0f

typedef NS_ENUM(NSInteger, TLMomentExtensionSectionType) {
    TLMomentExtensionSectionTypeLike,
    TLMomentExtensionSectionTypeComment,
};

@interface TLMomentExtensionView ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *angel;

@end

@implementation TLMomentExtensionView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.tableView = self.addTableView(1)
        .backgroundColor([UIColor colorGrayForMoment]).separatorStyle(UITableViewCellSeparatorStyleNone)
        .scrollsToTop(NO).scrollEnabled(NO)
        .masonry(^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(EDGE_HEADER);
            make.left.and.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self).priorityLow();
        })
        .view;
        
        self.angel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
    }
    return self;
}

- (void)setExtension:(TLMomentExtension *)extension
{
    _extension = extension;
    
    @weakify(self);
    self.angel.clear();
    
    // 点赞
    self.angel.addSection(TLMomentExtensionSectionTypeLike);
    if (extension.likedFriends.count > 0) {
        self.angel.addCell(@"TLMomentExtensionLikedCell").toSection(TLMomentExtensionSectionTypeLike).withDataModel(self.extension)
        .eventAction(^ id(TLMELikedCellEventType eventType, id data) {
            @strongify(self);
            if (eventType == TLMELikedCellEventTypeClickUser) {
                TLUserDetailViewController *userDetailVC = [[TLUserDetailViewController alloc] initWithUserModel:data];
                PushVC(userDetailVC);
            }
            return nil;
        });
    }
    
    // 评论
    self.angel.addSection(TLMomentExtensionSectionTypeComment);
    if (extension.comments.count > 0) {
        self.angel.addCells(@"TLMomentExtensionCommentCell").toSection(TLMomentExtensionSectionTypeComment).withDataModelArray(self.extension.comments)
        .eventAction(^ id(TLMECommentCellEventType eventType, id data) {
            @strongify(self);
            if (eventType == TLMECommentCellEventTypeUserClick) {
                TLUserDetailViewController *userDetailVC = [[TLUserDetailViewController alloc] initWithUserModel:data];
                PushVC(userDetailVC);
            }
            return nil;
        });
    }
    
    [self.tableView reloadData];
}

#pragma mark - # Private Methods
- (void)drawRect:(CGRect)rect
{
    CGFloat startX = 20;
    CGFloat startY = 0;
    CGFloat endY = EDGE_HEADER;
    CGFloat width = 6;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddLineToPoint(context, startX + width, endY);
    CGContextAddLineToPoint(context, startX - width, endY);
    CGContextClosePath(context);
    [[UIColor colorGrayForMoment] setFill];
    [[UIColor colorGrayForMoment] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
