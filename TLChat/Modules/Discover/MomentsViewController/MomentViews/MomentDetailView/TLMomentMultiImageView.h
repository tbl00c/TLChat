//
//  TLMomentMultiImageView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMomentViewDelegate.h"

@interface TLMomentMultiImageView : UIView

@property (nonatomic, assign) id<TLMomentMultiImageViewDelegate> delegate;

@property (nonatomic, strong) NSArray *images;

@end
