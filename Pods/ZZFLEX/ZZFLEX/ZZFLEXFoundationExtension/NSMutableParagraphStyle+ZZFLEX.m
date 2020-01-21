//
//  NSMutableParagraphStyle+ZZFLEX.m
//  Masonry
//
//  Created by 李伯坤 on 2019/8/30.
//

#import "NSMutableParagraphStyle+ZZFLEX.h"

@implementation NSMutableParagraphStyle (ZZFLEX)

+ (ZZMutableParagraphStyleChainModel *)zz_create;
{
    ZZMutableParagraphStyleChainModel *object = [[ZZMutableParagraphStyleChainModel alloc] initWithObject:nil];
    return object;
}

- (ZZMutableParagraphStyleChainModel *)zz_setup
{
    ZZMutableParagraphStyleChainModel *object = [[ZZMutableParagraphStyleChainModel alloc] initWithObject:self];
    return object;
}

@end
