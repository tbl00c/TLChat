//
//  NSMutableParagraphStyle+ZZFLEX.h
//  Masonry
//
//  Created by 李伯坤 on 2019/8/30.
//

#import <UIKit/UIKit.h>
#import "ZZMutableParagraphStyleChainModel.h"

@interface NSMutableParagraphStyle (ZZFLEX)

+ (ZZMutableParagraphStyleChainModel *)zz_create;

@property (nonatomic, strong, readonly) ZZMutableParagraphStyleChainModel *zz_setup;

@end

