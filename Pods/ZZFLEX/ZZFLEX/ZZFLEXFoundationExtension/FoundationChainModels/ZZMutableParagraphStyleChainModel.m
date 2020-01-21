//
//  ZZMutableParagraphStyleChainModel.m
//  Masonry
//
//  Created by 李伯坤 on 2019/8/30.
//

#import "ZZMutableParagraphStyleChainModel.h"

#define     ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(methodName, ZZParamType) \
- (ZZMutableParagraphStyleChainModel *(^)(ZZParamType param))methodName {   \
return ^ZZMutableParagraphStyleChainModel *(ZZParamType param) {    \
self.object.methodName = param;   \
return self;    \
};\
}


@implementation ZZMutableParagraphStyleChainModel

- (instancetype)initWithObject:(NSMutableParagraphStyle *)object
{
    if (self = [self init]) {
        _object = object ? object : [[NSMutableParagraphStyle alloc] init];
    }
    return self;
}

ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(lineSpacing, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(paragraphSpacing, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(alignment, NSTextAlignment);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(firstLineHeadIndent, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(headIndent, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(tailIndent, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(lineBreakMode, NSLineBreakMode);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(minimumLineHeight, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(maximumLineHeight, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(baseWritingDirection, NSWritingDirection);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(lineHeightMultiple, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(paragraphSpacingBefore, CGFloat);
ZZFLEX_FMPS_CHAIN_IMPLEMENTATION(hyphenationFactor, float);

@end
