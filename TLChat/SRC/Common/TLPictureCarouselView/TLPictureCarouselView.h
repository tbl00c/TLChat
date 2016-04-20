//
//  TLPictureCarouselView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPictureCarouselProtocol.h"

#define         DEFAULT_TIMEINTERVAL        5.0f

@class TLPictureCarouselView;
@protocol TLPictureCarouselDelegate <NSObject>

- (void)pictureCarouselView:(TLPictureCarouselView *)pictureCarouselView
              didSelectItem:(id<TLPictureCarouselProtocol>)model;

@end

@interface TLPictureCarouselView : UIView

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) id<TLPictureCarouselDelegate> delegate;

@property (nonatomic, assign) NSTimeInterval timeInterval;

@end
