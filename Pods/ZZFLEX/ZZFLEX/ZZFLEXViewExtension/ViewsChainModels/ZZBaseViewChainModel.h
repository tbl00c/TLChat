//
//  ZZBaseViewChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 链式API声明
#define     ZZFLEX_CHAIN_PROPERTY               @property (nonatomic, copy, readonly)
/// 一般链式API实现
#define     ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZViewChainModelType, ZZViewClass) \
- (ZZViewChainModelType (^)(ZZParamType param))methodName {   \
    return ^ZZViewChainModelType (ZZParamType param) {    \
        ((ZZViewClass *)self.view).methodName = param;   \
        return self;    \
    };\
}

/// UIKit拓展声明
#define     ZZFLEX_EX_INTERFACE(ZZView, ZZViewChainModelClass)   \
@interface ZZView (ZZFLEX_EX)   \
ZZFLEX_CHAIN_PROPERTY ZZViewChainModelClass *zz_make;    \
+ (ZZViewChainModelClass *(^)(NSInteger tag))zz_create;   \
@end
/// UIKit拓展实现
#define     ZZFLEX_EX_IMPLEMENTATION(ZZView, ZZViewChainModelClass) \
@implementation ZZView (ZZFLEX_EX)  \
+ (ZZViewChainModelClass *(^)(NSInteger tag))zz_create {\
    return ^ZZViewChainModelClass *(NSInteger tag){    \
        ZZView *view = [[ZZView alloc] init];   \
        return [[ZZViewChainModelClass alloc] initWithTag:tag andView:view];    \
    };\
}\
- (ZZViewChainModelClass *)zz_make {   \
    return [[ZZViewChainModelClass alloc] initWithTag:self.tag andView:self];    \
}   \
@end

@class MASConstraintMaker;
@interface ZZBaseViewChainModel <ObjcType> : NSObject

/// 视图的唯一标示
@property (nonatomic, assign, readonly) NSInteger tag;

/// 视图的唯一标示
@property (nonatomic, strong, readonly) __kindof UIView *view;

@property (nonatomic, assign, readonly) Class viewClass;

- (instancetype)initWithTag:(NSInteger)tag andView:(__kindof UIView *)view;

#pragma mark - # Frame
ZZFLEX_CHAIN_PROPERTY ObjcType (^ frame)(CGRect frame);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ origin)(CGPoint origin);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ x)(CGFloat x);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ y)(CGFloat y);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ size)(CGSize size);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ width)(CGFloat width);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ height)(CGFloat height);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ center)(CGPoint center);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ centerX)(CGFloat centerX);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ centerY)(CGFloat centerY);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ top)(CGFloat top);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ bottom)(CGFloat bottom);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ left)(CGFloat left);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ right)(CGFloat right);

#pragma mark - # Layout
ZZFLEX_CHAIN_PROPERTY ObjcType (^ masonry)( void (^constraints)(MASConstraintMaker *make) );
ZZFLEX_CHAIN_PROPERTY ObjcType (^ updateMasonry)( void (^constraints)(MASConstraintMaker *make) );
ZZFLEX_CHAIN_PROPERTY ObjcType (^ remakeMasonry)( void (^constraints)(MASConstraintMaker *make) );

#pragma mark - # Color
ZZFLEX_CHAIN_PROPERTY ObjcType (^ backgroundColor)(UIColor *backgroundColor);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ tintColor)(UIColor *tintColor);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ alpha)(CGFloat alpha);

#pragma mark - # Control
ZZFLEX_CHAIN_PROPERTY ObjcType (^ contentMode)(UIViewContentMode contentMode);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ opaque)(BOOL opaque);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ hidden)(BOOL hidden);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ clipsToBounds)(BOOL clipsToBounds);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ userInteractionEnabled)(BOOL userInteractionEnabled);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ multipleTouchEnabled)(BOOL multipleTouchEnabled);

#pragma mark - # Layer
ZZFLEX_CHAIN_PROPERTY ObjcType (^ masksToBounds)(BOOL masksToBounds);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ cornerRadius)(CGFloat cornerRadius);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ border)(CGFloat borderWidth, UIColor *borderColor);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ borderWidth)(CGFloat borderWidth);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ borderColor)(CGColorRef borderColor);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ zPosition)(CGFloat zPosition);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ anchorPoint)(CGPoint anchorPoint);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ shadow)(CGSize shadowOffset, CGFloat shadowRadius, UIColor *shadowColor, CGFloat shadowOpacity);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ shadowColor)(CGColorRef shadowColor);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ shadowOpacity)(CGFloat shadowOpacity);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ shadowOffset)(CGSize shadowOffset);
ZZFLEX_CHAIN_PROPERTY ObjcType (^ shadowRadius)(CGFloat shadowRadius);

ZZFLEX_CHAIN_PROPERTY ObjcType (^ transform)(CATransform3D transform);

@end
