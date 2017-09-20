//
//  TLPictureCarouselViewCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPictureCarouselProtocol.h"

@interface TLPictureCarouselViewCell : UICollectionViewCell

@property (nonatomic, strong) id<TLPictureCarouselProtocol> model;

@end
