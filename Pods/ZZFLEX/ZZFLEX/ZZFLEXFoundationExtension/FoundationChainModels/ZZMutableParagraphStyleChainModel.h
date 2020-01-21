//
//  ZZMutableParagraphStyleChainModel.h
//  Masonry
//
//  Created by 李伯坤 on 2019/8/30.
//

#import <Foundation/Foundation.h>

#define     ZZFLEX_FMPS_CHAIN_PROPERTY   @property (nonatomic, copy, readonly)

@interface ZZMutableParagraphStyleChainModel : NSObject

@property (nonatomic, strong, readonly) NSMutableParagraphStyle *object;

- (instancetype)initWithObject:(NSMutableParagraphStyle *)object;

ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ lineSpacing)(CGFloat lineSpacing);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ paragraphSpacing)(CGFloat paragraphSpacing);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ alignment)(NSTextAlignment alignment);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ firstLineHeadIndent)(CGFloat firstLineHeadIndent);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ headIndent)(CGFloat headIndent);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ tailIndent)(CGFloat tailIndent);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ lineBreakMode)(NSLineBreakMode lineBreakMode);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ minimumLineHeight)(CGFloat minimumLineHeight);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ maximumLineHeight)(CGFloat maximumLineHeight);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ baseWritingDirection)(NSWritingDirection baseWritingDirection);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ lineHeightMultiple)(CGFloat lineHeightMultiple);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ paragraphSpacingBefore)(CGFloat paragraphSpacingBefore);
ZZFLEX_FMPS_CHAIN_PROPERTY ZZMutableParagraphStyleChainModel *(^ hyphenationFactor)(float hyphenationFactor);

@end


