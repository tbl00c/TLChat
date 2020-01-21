//
//  NSMutableAttributedString+ZZFLEX.h
//  Masonry
//
//  Created by 李伯坤 on 2019/8/30.
//

#import <Foundation/Foundation.h>
#import "ZZMutableAttributeStringChainModel.h"

@interface NSMutableAttributedString (ZZFLEX)

+ (ZZMutableAttributeStringChainModel *(^)(NSString *str))zz_create;

@property (nonatomic, strong, readonly) ZZMutableAttributeStringChainModel *zz_setup;

@end

