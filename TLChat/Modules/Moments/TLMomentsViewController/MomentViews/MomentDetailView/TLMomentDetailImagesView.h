//
//  TLMomentDetailImagesView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLMomentDetailImagesView : UIView

@property (nonatomic, copy) void (^imageSelectedAction)(NSArray *images, NSInteger index);

@property (nonatomic, strong) NSArray *images;

- (instancetype)initWithImageSelectedAction:(void (^)(NSArray *images, NSInteger index))imageSelectedAction;

@end
