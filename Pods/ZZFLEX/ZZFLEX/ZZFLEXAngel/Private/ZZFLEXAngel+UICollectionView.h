//
//  ZZFLEXAngel+UICollectionView.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2017/12/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZFLEXAngel.h"
#import "ZZFlexibleLayoutFlowLayout.h"

@interface ZZFLEXAngel (UICollectionView) <
UICollectionViewDataSource,
UICollectionViewDelegate,
ZZFlexibleLayoutFlowLayoutDelegate      // 继承自 UICollectionViewDelegateFlowLayout
>

@end
