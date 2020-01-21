//
//  UIButton+Extensions.h
//  TLKit
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 libokun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLButtonImagePosition) {
    TLButtonImagePositionLeft = 0,              //图片在左，文字在右，默认
    TLButtonImagePositionRight = 1,             //图片在右，文字在左
    TLButtonImagePositionTop = 2,               //图片在上，文字在下
    TLButtonImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (Extensions)

/**
 *  设置Button的背景色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  快捷设置图片
 */
- (void)setImage:(UIImage *)image imageHL:(UIImage *)imageHL;


/**
 *  image和title图文混排
 *
 *  @param  position    图片的位置，默认left
 *  @param  spacing     图片和标题的间隔
 *
 *  @return     返回button最小的size
 *
 *  注意，需要先设置好image、title、font。网络图片需要下载完成后再调用此方法，或设置同大小的placeholder
 */
- (CGSize)setButtonImagePosition:(TLButtonImagePosition)position spacing:(CGFloat)spacing;

@end
