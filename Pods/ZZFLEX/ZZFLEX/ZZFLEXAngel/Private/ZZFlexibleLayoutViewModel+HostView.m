//
//  ZZFlexibleLayoutViewModel+HostView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel+HostView.h"

@implementation ZZFlexibleLayoutViewModel (HostView)

- (CGSize)visableSizeForHostView:(__kindof UIView *)hostView
{
    return [self visableSizeForHostView:hostView sectionEdge:UIEdgeInsetsZero];
}

- (CGSize)visableSizeForHostView:(__kindof UIView *)hostView sectionEdge:(UIEdgeInsets)sectionEdge
{
    CGFloat width = self.viewSize.width;
    width = width < 0 ? (hostView.frame.size.width - sectionEdge.left - sectionEdge.right) * -width : width;
    
    CGFloat height = self.viewSize.height;
    height = height < 0 ? (hostView.frame.size.height - sectionEdge.top - sectionEdge.bottom) * -height : height;
    
    return CGSizeMake(width, height);
}

- (void)excuteConfigActionForPageControler:(id)pageController
                                  hostView:(__kindof UIView *)hostView
                                  itemView:(__kindof UIView<ZZFlexibleLayoutViewProtocol> *)itemView
                              sectionCount:(NSInteger)sectionCount
                                 indexPath:(NSIndexPath *)indexPath
{
    if ([itemView respondsToSelector:@selector(setViewDataModel:)]) {
        [itemView setViewDataModel:self.dataModel];
    }
    if ([itemView respondsToSelector:@selector(setViewDelegate:)]) {
        [itemView setViewDelegate:self.delegate ? self.delegate : pageController];
    }
    if ([itemView respondsToSelector:@selector(setViewEventAction:)]) {
        [itemView setViewEventAction:self.eventAction];
    }
    if ([itemView respondsToSelector:@selector(onViewPositionUpdatedWithIndexPath:sectionItemCount:)]) {
        [itemView onViewPositionUpdatedWithIndexPath:indexPath sectionItemCount:sectionCount];
    }
    [itemView setTag:self.viewTag];
    if (self.configAction) {
        self.configAction(itemView, self.dataModel);
    }
}

- (void)excuteSelectedActionForHostView:(__kindof UIView *)hostView
{
    if (self.selectedAction) {
        self.selectedAction(self.dataModel);
    }
}

@end
