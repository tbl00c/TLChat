//
//  UIButton+TLWebImage.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+TLWebImage.h"

@interface UIButton (TLWebImage)

- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(UIImage *)placeholder
                   options:(TLWebImageOptions)options
                 completed:(TLWebImageDownloadCompleteBlock)completedBlock;

- (void)tt_cancelImageLoadForState:(UIControlState)state;

#pragma mark - # BackgroundImage
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options completed:(TLWebImageDownloadCompleteBlock)completedBlock;

- (void)tt_cancelBackgroundImageLoadForState:(UIControlState)state;
@end
