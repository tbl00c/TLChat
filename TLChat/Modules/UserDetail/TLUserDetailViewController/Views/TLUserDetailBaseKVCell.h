//
//  TLUserDetailBaseKVCell.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/7.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLUserDetailKVModel;
TLUserDetailKVModel *createUserDetailKVModel(NSString *title, id data);

@interface TLUserDetailKVModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) id data;

@property (nonatomic, assign) BOOL hiddenArrow;

@property (nonatomic, assign) BOOL selectable;

@end

@interface TLUserDetailBaseKVCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *detailContentView;

@end
