//
//  TLExpressionDownloadButton.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionDownloadButton.h"

@interface TLExpressionDownloadButton ()

@property (nonatomic, strong) UIButton *downloadButton;

@property (nonatomic, strong) UIView *progressView;

@end

@implementation TLExpressionDownloadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:3];
        [self.layer setBorderWidth:1];
        
        self.progressView = self.addView(1)
        .backgroundColor([UIColor colorGreenDefault])
        .view;
        
        @weakify(self);
        self.downloadButton = self.addButton(2)
        .titleFont([UIFont systemFontOfSize:14.0f])
        .masonry(^ (MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .eventBlock(UIControlEventTouchUpInside, ^(UIButton *sender) {
            @strongify(self);
            if (self.downloadButtonClick) {
                self.downloadButtonClick();
            }
        })
        .view;
        
        [self setStatus:TLExpressionDownloadButtonStatusNet];
    }
    return self;
}

- (void)setStatus:(TLExpressionDownloadButtonStatus)status
{
    _status = status;
    if (status == TLExpressionDownloadButtonStatusNet) {
        self.downloadButton.zz_make.title(LOCSTR(@"下载")).titleColor([UIColor colorGreenDefault]).userInteractionEnabled(YES);
        [self.layer setBorderColor:[UIColor colorGreenDefault].CGColor];
        [self.progressView setHidden:YES];
    }
    else if (status == TLExpressionDownloadButtonStatusDownloaded) {
        self.downloadButton.zz_make.title(LOCSTR(@"已下载")).titleColor([UIColor colorGrayLine]).userInteractionEnabled(NO);
        [self.layer setBorderColor:[UIColor colorGrayLine].CGColor];
        [self.progressView setHidden:YES];
    }
    else {
        self.downloadButton.zz_make.title(LOCSTR(@"下载中")).titleColor([UIColor whiteColor]).userInteractionEnabled(NO);
        [self.layer setBorderColor:[UIColor colorGreenDefault].CGColor];
        [self.progressView setHidden:NO];
    }
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self.progressView setFrame:CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height)];
}

@end
