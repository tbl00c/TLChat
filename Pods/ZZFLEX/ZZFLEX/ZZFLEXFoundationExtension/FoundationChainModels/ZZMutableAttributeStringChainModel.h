//
//  ZZMutableAttributeStringChainModel.h
//  ZZFLEX
//
//  Created by 李伯坤 on 2019/8/30.
//

#import <UIKit/UIKit.h>

#define     ZZFLEX_FMAS_CHAIN_PROPERTY               @property (nonatomic, copy, readonly)

@interface ZZMutableAttributeStringChainModel : NSObject

@property (nonatomic, strong, readonly) NSMutableAttributedString *object;

- (instancetype)initWithObject:(NSMutableAttributedString *)object;

#pragma mark - # 功能
/// 拼接
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ append)(NSAttributedString *attrStr);

/// 插入
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ insert)(NSAttributedString *attrStr, NSInteger index);

/// 替换
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ replace)(NSAttributedString *attrStr, NSRange range);

/// 删除
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ remove)(NSRange range);

/// 拼接图片
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ appendImage)(UIImage *image, CGRect bounds);

/// 拼接无属性字符串
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ appendString)(NSString *str);

/// 拼接附属
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ appendAttachment)(NSTextAttachment *attachment);

#pragma mark - # 属性
/// 字体
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ font)(UIFont *font);
/// 颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ foregroundColor)(UIColor *foregroundColor);

/// 段落格式
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ paragraphStyle)(NSParagraphStyle *paragraphStyle);

/// 背景色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ backgroundColor)(UIColor *bgColor);

/// 连体
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ ligature)(NSInteger ligature);

/// 字符间距
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ kern)(NSInteger kern);

/// 删除线
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strikethroughStyle)(NSInteger strikethroughStyle);
/// 删除线颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strikethroughColor)(UIColor *strikethroughColor);

/// 下划线
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ underlineStyle)(NSUnderlineStyle underlineStyle);
/// 下划线颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ underlineColor)(UIColor *underlineColor);

/// 笔画宽度(粗细)
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strokeWidth)(NSInteger strokeWidth);
/// 笔画填充颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strokeColor)(UIColor *strokeColor);

/// 阴影
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ shadow)(NSShadow *shadow);

/// 文本特殊效果
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ textEffect)(NSString *textEffect);

/// 基线偏移值
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ baselineOffset)(CGFloat baselineOffset);
/// 字形倾斜度
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ obliqueness)(CGFloat obliqueness);
/// 文本横向拉伸
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ expansion)(CGFloat expansion);

/// 文字书写方向
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ writingDirection)(NSInteger writingDirection);
/// 文字排版方向
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ verticalGlyph)(NSInteger verticalGlyph);

/// 链接属性
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ link)(NSURL *link);

/// 文本附
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ attachment)(NSTextAttachment *attachment);

#pragma mark - # 属性（带Range）
/// 字体
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ fontWithRange)(UIFont *font, NSRange range);
/// 颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ foregroundColorWithRange)(UIColor *foregroundColor, NSRange range);

/// 段落格式
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ paragraphStyleWithRange)(NSParagraphStyle *paragraphStyle, NSRange range);

/// 背景色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ backgroundColorWithRange)(UIColor *bgColor, NSRange range);

/// 连体
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ ligatureWithRange)(NSInteger ligature, NSRange range);

/// 字符间距
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ kernWithRange)(NSInteger kern, NSRange range);

/// 删除线
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strikethroughStyleWithRange)(NSInteger strikethroughStyle, NSRange range);
/// 删除线颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strikethroughColorWithRange)(UIColor *strikethroughColor, NSRange range);

/// 下划线
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ underlineStyleWithRange)(NSUnderlineStyle underlineStyle, NSRange range);
/// 下划线颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ underlineColorWithRange)(UIColor *underlineColor, NSRange range);

/// 笔画宽度(粗细)
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strokeWidthWithRange)(NSInteger strokeWidth, NSRange range);
/// 笔画填充颜色
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ strokeColorWithRange)(UIColor *strokeColor, NSRange range);

/// 阴影
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ shadowWithRange)(NSShadow *shadow, NSRange range);

/// 文本特殊效果
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ textEffectWithRange)(NSString *textEffect, NSRange range);

/// 基线偏移值
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ baselineOffsetWithRange)(CGFloat baselineOffset, NSRange range);
/// 字形倾斜度
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ obliquenessWithRange)(CGFloat obliqueness, NSRange range);
/// 文本横向拉伸
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ expansionWithRange)(CGFloat expansion, NSRange range);

/// 文字书写方向
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ writingDirectionWithRange)(NSInteger writingDirection, NSRange range);
/// 文字排版方向
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ verticalGlyphWithRange)(NSInteger verticalGlyph, NSRange range);

/// 链接属性
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ linkWithRange)(NSURL *link, NSRange range);

/// 文本附
ZZFLEX_FMAS_CHAIN_PROPERTY ZZMutableAttributeStringChainModel *(^ attachmentWithRange)(NSTextAttachment *attachment, NSRange range);


@end

