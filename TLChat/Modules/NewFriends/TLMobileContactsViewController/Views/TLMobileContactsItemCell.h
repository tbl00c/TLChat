//
//  TLMobileContactsItemCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMobileContactModel.h"

@interface TLMobileContactsItemCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLMobileContactModel *contact;

@end
