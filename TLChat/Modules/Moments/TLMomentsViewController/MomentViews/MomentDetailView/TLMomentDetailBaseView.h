//
//  TLMomentDetailBaseView.h
//  TLChat
//
//  Created by 李伯坤 on 16/5/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMomentDetail.h"
#import "TLMomentViewDelegate.h"

@interface TLMomentDetailBaseView : UIView

@property (nonatomic, assign) id<TLMomentDetailViewDelegate> delegate;

@property (nonatomic, strong) TLMomentDetail *detail;

@end
