//
//  TLMomentBaseCell.h
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"
#import "TLMoment.h"
#import "TLMomentViewDelegate.h"

@interface TLMomentBaseCell : TLTableViewCell

@property (nonatomic, assign) id<TLMomentViewDelegate> delegate;

@property (nonatomic, strong) TLMoment *moment;

@end
