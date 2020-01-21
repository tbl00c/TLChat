//
//  ZZMutableAttributeStringChainModel.m
//  ZZFLEX
//
//  Created by 李伯坤 on 2019/8/30.
//

#import "ZZMutableAttributeStringChainModel.h"

#define     ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZAttributeName) \
- (ZZMutableAttributeStringChainModel *(^)(ZZParamType param))methodName {   \
return ^ZZMutableAttributeStringChainModel *(ZZParamType param) {    \
[self.object addAttribute:ZZAttributeName value:@(param) range:NSMakeRange(0, self.object.length)];   \
return self;    \
};\
}

#define     ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZAttributeName) \
- (ZZMutableAttributeStringChainModel *(^)(ZZParamType param))methodName {   \
return ^ZZMutableAttributeStringChainModel *(ZZParamType param) {    \
[self.object addAttribute:ZZAttributeName value:param range:NSMakeRange(0, self.object.length)];   \
return self;    \
};\
}

#define     ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZAttributeName) \
- (ZZMutableAttributeStringChainModel *(^)(ZZParamType param, NSRange range))methodName {   \
return ^ZZMutableAttributeStringChainModel *(ZZParamType param, NSRange range) {    \
[self.object addAttribute:ZZAttributeName value:@(param) range:range];   \
return self;    \
};\
}

#define     ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZAttributeName) \
- (ZZMutableAttributeStringChainModel *(^)(ZZParamType param, NSRange range))methodName {   \
return ^ZZMutableAttributeStringChainModel *(ZZParamType param, NSRange range) {    \
[self.object addAttribute:ZZAttributeName value:param range:range];   \
return self;    \
};\
}

@implementation ZZMutableAttributeStringChainModel

- (instancetype)initWithObject:(NSMutableAttributedString *)object
{
    if (self = [self init]) {
        _object = object ? object : [[NSMutableAttributedString alloc] init];
    }
    return self;
}

#pragma mark - # 功能
- (ZZMutableAttributeStringChainModel *(^)(NSAttributedString *attrStr))append
{
    return ^ZZMutableAttributeStringChainModel *(NSAttributedString *attrStr) {
        [self.object appendAttributedString:attrStr];
        return self;
    };
}

- (ZZMutableAttributeStringChainModel *(^)(NSAttributedString *attrStr, NSInteger index))insert
{
    return ^ZZMutableAttributeStringChainModel *(NSAttributedString *attrStr, NSInteger index) {
        [self.object insertAttributedString:attrStr atIndex:index];
        return self;
    };
}

- (ZZMutableAttributeStringChainModel *(^)(NSAttributedString *attrStr, NSRange range))replace
{
    return ^ZZMutableAttributeStringChainModel *(NSAttributedString *attrStr, NSRange range) {
        [self.object replaceCharactersInRange:range withAttributedString:attrStr];
        return self;
    };
}

- (ZZMutableAttributeStringChainModel *(^)(NSRange range))remove
{
    return ^ZZMutableAttributeStringChainModel *(NSRange range) {
        [self.object deleteCharactersInRange:range];
        return self;
    };
}

- (ZZMutableAttributeStringChainModel *(^)(UIImage *image, CGRect bounds))appendImage
{
    return ^ZZMutableAttributeStringChainModel *(UIImage *image, CGRect bounds) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        [attachment setImage:image];
        [attachment setBounds:bounds];
        NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [self.object appendAttributedString:attrStr];
        return self;
    };
}

- (ZZMutableAttributeStringChainModel *(^)(NSString *str))appendString
{
    return ^ZZMutableAttributeStringChainModel *(NSString *str) {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str];
        [self.object appendAttributedString:attrStr];
        return self;
    };
}

- (ZZMutableAttributeStringChainModel *(^)(NSTextAttachment *attachment))appendAttachment
{
    return ^ZZMutableAttributeStringChainModel *(NSTextAttachment *attachment) {
        NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [self.object appendAttributedString:attrStr];
        return self;
    };
}

#pragma mark - # 属性
/// 字体
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(font, UIFont *, NSFontAttributeName)

/// 颜色
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(foregroundColor, UIColor *, NSForegroundColorAttributeName)

/// 背景色
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(backgroundColor, UIColor *, NSBackgroundColorAttributeName)

/// 段落格式
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(paragraphStyle, NSParagraphStyle *, NSParagraphStyleAttributeName)

/// 连体
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(ligature, NSInteger, NSLigatureAttributeName)

/// 字符间距
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(kern, NSInteger, NSKernAttributeName)

/// 删除线
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(strikethroughStyle, NSInteger, NSStrikethroughStyleAttributeName)
/// 删除线颜色
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(strikethroughColor, UIColor *, NSStrikethroughColorAttributeName)

/// 下划线
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(underlineStyle, NSUnderlineStyle, NSUnderlineStyleAttributeName)
/// 下划线颜色
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(underlineColor, UIColor *, NSUnderlineColorAttributeName)

/// 笔画宽度(粗细)
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(strokeWidth, NSInteger, NSStrokeWidthAttributeName)
/// 笔画填充颜色
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(strokeColor, UIColor *, NSStrokeColorAttributeName)

/// 阴影
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(shadow, NSShadow *, NSShadowAttributeName)

/// 文本特殊效果
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(textEffect, NSString *, NSTextEffectAttributeName)

/// 基线偏移值
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(baselineOffset, CGFloat, NSBaselineOffsetAttributeName)
/// 字形倾斜度
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(obliqueness, CGFloat, NSObliquenessAttributeName)
/// 文本横向拉伸
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(expansion, CGFloat, NSExpansionAttributeName)

/// 文字书写方向
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(writingDirection, NSInteger, NSWritingDirectionAttributeName)
/// 文字排版方向
ZZFLEX_FMAS_NUM_ATTR_CHAIN_IMPLEMENTATION(verticalGlyph, NSInteger, NSVerticalGlyphFormAttributeName)

/// 链接属性
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(link, NSURL *, NSLinkAttributeName)

/// 文本附
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(attachment, NSTextAttachment *, NSAttachmentAttributeName)

#pragma mark - # 属性（带Range）
/// 字体
ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(fontWithRange, UIFont *, NSFontAttributeName)

/// 颜色
ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(foregroundColorWithRange, UIColor *, NSForegroundColorAttributeName)

/// 背景色
ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(backgroundColorWithRange, UIColor *, NSBackgroundColorAttributeName)

/// 段落格式
ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(paragraphStyleWithRange, NSParagraphStyle *, NSParagraphStyleAttributeName)

/// 连体
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(ligatureWithRange, NSInteger, NSLigatureAttributeName)

/// 字符间距
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(kernWithRange, NSInteger, NSKernAttributeName)

/// 删除线
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(strikethroughStyleWithRange, NSInteger, NSStrikethroughStyleAttributeName)
/// 删除线颜色
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(strikethroughColorWithRange, UIColor *, NSStrikethroughColorAttributeName)

/// 下划线
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(underlineStyleWithRange, NSUnderlineStyle, NSUnderlineStyleAttributeName)
/// 下划线颜色
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(underlineColorWithRange, UIColor *, NSUnderlineColorAttributeName)

/// 笔画宽度(粗细)
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(strokeWidthWithRange, NSInteger, NSStrokeWidthAttributeName)
/// 笔画填充颜色
ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(strokeColorWithRange, UIColor *, NSStrokeColorAttributeName)

/// 阴影
ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(shadowWithRange, NSShadow *, NSShadowAttributeName)

/// 文本特殊效果
ZZFLEX_FMAS_ATTR_RANGE_CHAIN_IMPLEMENTATION(textEffectWithRange, NSString *, NSTextEffectAttributeName)

/// 基线偏移值
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(baselineOffsetWithRange, CGFloat, NSBaselineOffsetAttributeName)
/// 字形倾斜度
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(obliquenessWithRange, CGFloat, NSObliquenessAttributeName)
/// 文本横向拉伸
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(expansionWithRange, CGFloat, NSExpansionAttributeName)

/// 文字书写方向
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(writingDirectionWithRange, NSInteger, NSWritingDirectionAttributeName)
/// 文字排版方向
ZZFLEX_FMAS_NUM_ATTR_RANGE_CHAIN_IMPLEMENTATION(verticalGlyphWithRange, NSInteger, NSVerticalGlyphFormAttributeName)

/// 链接属性
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(linkWithRange, NSURL *, NSLinkAttributeName)

/// 文本附
ZZFLEX_FMAS_ATTR_CHAIN_IMPLEMENTATION(attachmentWithRange, NSTextAttachment *, NSAttachmentAttributeName)

@end
