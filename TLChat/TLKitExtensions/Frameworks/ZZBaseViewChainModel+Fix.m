//
//  ZZBaseViewChainModel+Fix.m
//  TLChat
//
//  Created by 李伯坤 on 2017/12/11.
//  Copyright © 2017年 EIMS. All rights reserved.
//

#import "ZZBaseViewChainModel+Fix.h"

@implementation ZZBaseViewChainModel (Fix)

- (ZZBaseViewChainModel *(^)( void (^constraints)(MASConstraintMaker *make) ))masonry
{
    return ^ZZBaseViewChainModel *( void (^constraints)(MASConstraintMaker *make) ) {
        [self.view mas_makeConstraints:constraints];
        return self;
    };
}

- (ZZBaseViewChainModel *(^)( void (^constraints)(MASConstraintMaker *make) ))updateMasonry
{
    return ^ZZBaseViewChainModel *( void (^constraints)(MASConstraintMaker *make) ) {
        [self.view mas_updateConstraints:constraints];
        return self;
    };
}

- (ZZBaseViewChainModel *(^)( void (^constraints)(MASConstraintMaker *make) ))remakeMasonry
{
    return ^ZZBaseViewChainModel *( void (^constraints)(MASConstraintMaker *make) ) {
        [self.view mas_remakeConstraints:constraints];
        return self;
    };
}

@end
