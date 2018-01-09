
//
//  UIView+TipView.m
//  Pods
//
//  Created by 李伯坤 on 2017/8/30.
//
//

#import "UIView+TipView.h"
#import "NSObject+Association.h"

@interface UIView (TipViewPrivate)

@property (nonatomic, strong) id __tt_tipview_userData;

@property (nonatomic, copy) void (^__tt_tipview_retryAction)(id userData);

@end

@implementation UIView (TipViewPrivate)

- (void)set__tt_tipview_userData:(id)__tt_tipview_userData
{
    [self setAssociatedObject:__tt_tipview_userData forKey:@"__tt_tipview_userData" association:TLAssociationStrong isAtomic:NO];
}
- (id)__tt_tipview_userData
{
    return [self associatedObjectForKey:@"__tt_tipview_userData"];
}

- (void)set__tt_tipview_retryAction:(void (^)(id))__tt_tipview_retryAction
{
    [self setAssociatedObject:__tt_tipview_retryAction forKey:@"__tt_tipview_retryAction" association:TLAssociationStrong isAtomic:NO];
}
- (void (^)(id))__tt_tipview_retryAction
{
    return [self associatedObjectForKey:@"__tt_tipview_retryAction"];
}

@end



#pragma mark - ## UIView (TipView)
@implementation UIView (TipView)

- (void)showTipView:(UIView *)tipView retryAction:(void (^)(id userData))retryAction
{
    [self showTipView:tipView userData:nil retryAction:retryAction];
}

- (void)showTipView:(UIView *)tipView userData:(id)userData retryAction:(void (^)(id userData))retryAction
{
    if (!tipView) {
        return;
    }
    if (tipView.superview) {
        [tipView removeFromSuperview];
    }
    
    [self setTt_tipView:tipView];
    [self set__tt_tipview_userData:userData];
    [self set__tt_tipview_retryAction:retryAction];
    if (CGRectEqualToRect(tipView.frame, CGRectZero)) {
        if (!CGRectEqualToRect(self.bounds, CGRectZero)) {
            [tipView setFrame:self.bounds];
        }
        else {
            CGRect rect = [UIScreen mainScreen].bounds;
            rect.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height - 44;
            [tipView setFrame:rect];
        }
    }
    
    [self addSubview:tipView];
    
    if (retryAction) {
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__tt_didClickTipView)];
        [tipView addGestureRecognizer:tapGR];
    }
}

- (void)removeTipView
{
    if (self.tt_tipView) {
        [self.tt_tipView removeFromSuperview];
    }
}

- (void)setTt_tipView:(UIView *)tt_tipView
{
    [self setAssociatedObject:tt_tipView forKey:@"__tt_tipView" association:TLAssociationStrong isAtomic:NO];
}
- (UIView *)tt_tipView
{
    return [self associatedObjectForKey:@"__tt_tipView"];
}

#pragma mark - # Event Response
- (void)__tt_didClickTipView
{
    [self removeTipView];
    if (self.__tt_tipview_retryAction) {
        self.__tt_tipview_retryAction(self.__tt_tipview_retryAction);
    }
}


@end
