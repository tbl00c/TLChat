//
//  TLSettingItemDeleteButtonCell.h
//  TLChat
//
//  Created by 李伯坤 on 2018/3/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLSettingItemDeleteButtonCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, copy) id (^eventAction)(NSInteger, id);

@end
