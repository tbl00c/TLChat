//
//  TLUserDetailBaseInfoCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLUser.h"

@interface TLUserDetailBaseInfoCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLUser *userModel;

@end
