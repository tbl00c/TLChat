//
//  NSMutableAttributedString+ZZFLEX.m
//  Masonry
//
//  Created by 李伯坤 on 2019/8/30.
//

#import "NSMutableAttributedString+ZZFLEX.h"

@implementation NSMutableAttributedString (ZZFLEX)

+ (ZZMutableAttributeStringChainModel *(^)(NSString *str))zz_create;
{
    return ^ZZMutableAttributeStringChainModel *(NSString *str) {
        NSMutableAttributedString *attrStr = str ? [[NSMutableAttributedString alloc] initWithString:str] : [[NSMutableAttributedString alloc] init];
        ZZMutableAttributeStringChainModel *object = [[ZZMutableAttributeStringChainModel alloc] initWithObject:attrStr];
        return object;
    };
}

- (ZZMutableAttributeStringChainModel *)zz_setup
{
    ZZMutableAttributeStringChainModel *object = [[ZZMutableAttributeStringChainModel alloc] initWithObject:self];
    return object;
}

@end
