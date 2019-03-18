//
//  ZZFlexibleLayoutFlowLayout.m
//  zhuanzhuan
//
//  Created by lbk on 2017/5/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZFlexibleLayoutFlowLayout.h"

#pragma mark - # ZZFlexibleLayoutAttributes
@interface ZZFlexibleLayoutAttributes : UICollectionViewLayoutAttributes
/// 背景色
@property (nonatomic, strong) UIColor *backgroudColor;

@end

@implementation ZZFlexibleLayoutAttributes

@end


#pragma mark - # ZZFlexibleLayoutReusableView
@interface ZZFlexibleLayoutReusableView : UICollectionReusableView

@end

@implementation ZZFlexibleLayoutReusableView

- (void)applyLayoutAttributes:(ZZFlexibleLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    self.backgroundColor = layoutAttributes.backgroudColor;
}

@end


#pragma mark - # ZZFlexibleLayoutFlowLayout
@interface ZZFlexibleLayoutFlowLayout  ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttributes;

@end

@implementation ZZFlexibleLayoutFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    id<ZZFlexibleLayoutFlowLayoutDelegate> delegate = (id<ZZFlexibleLayoutFlowLayoutDelegate>)self.collectionView.delegate;
    if (!(delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:colorForSectionAtIndex:)])) {
        return;
    }
    
    [self.decorationViewAttributes removeAllObjects];
    [self registerClass:[ZZFlexibleLayoutReusableView class] forDecorationViewOfKind:@"ZZFlexibleLayoutReusableView"];
    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section++) {
        UIColor *sectionBGColor = [delegate collectionView:self.collectionView layout:self colorForSectionAtIndex:section];
        if (CGColorEqualToColor(sectionBGColor.CGColor, self.collectionView.backgroundColor.CGColor)) {
            continue;
        }
        
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        
        UICollectionViewLayoutAttributes *firstAttribute;
        UICollectionViewLayoutAttributes *lastAttribute;
        @try {
            firstAttribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            lastAttribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numberOfItems - 1) inSection:section]];
        }
        @catch (NSException *exception) {}
        
        // 获取section的edgeInsets
        UIEdgeInsets sectionInset = self.sectionInset;
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            if (!UIEdgeInsetsEqualToEdgeInsets(inset, sectionInset)) {
                sectionInset = inset;
            }
        }
        
        // 计算section的范围
        CGRect sectionFrame = CGRectUnion(firstAttribute.frame, lastAttribute.frame);
        sectionFrame.origin.x -= sectionInset.left;
        sectionFrame.origin.y -= sectionInset.top;
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.frame.size.height;
        }
        else{
            sectionFrame.size.width = self.collectionView.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        // 配置
        ZZFlexibleLayoutAttributes *attribute = [ZZFlexibleLayoutAttributes layoutAttributesForDecorationViewOfKind:@"ZZFlexibleLayoutReusableView" withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        [attribute setFrame:sectionFrame];
        [attribute setZIndex:-1];
        [attribute setBackgroudColor:sectionBGColor];
        [self.decorationViewAttributes addObject:attribute];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    @try {
        [self p_layoutHeaderFooterAttributes:superArray forElementsInRect:rect];
        [self p_layoutBackgrounColorAttributes:superArray forElementsInRect:rect];
    } @catch (NSException *exception) { }
    return superArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}

#pragma mark - # Private Methods
/// header footer悬浮
- (void)p_layoutHeaderFooterAttributes:(NSMutableArray *)superArray forElementsInRect:(CGRect)rect
{
    // section Header 悬浮
    NSMutableIndexSet *noneHeaderSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            [noneHeaderSections addIndex:attributes.indexPath.section];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [noneHeaderSections removeIndex:attributes.indexPath.section];
        }
    }
    
    [noneHeaderSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop){
        if ([self.collectionView numberOfItemsInSection:idx] > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            if (attributes) {
                [superArray addObject:attributes];
            }
        }
    }];
    
    //遍历superArray，改变header结构信息中的参数，使它可以在当前section还没完全离开屏幕的时候一直显示
    id<ZZFlexibleLayoutFlowLayoutDelegate> delegate = (id<ZZFlexibleLayoutFlowLayoutDelegate>)self.collectionView.delegate;
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            NSInteger section = attributes.indexPath.section;
            NSInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:section];
            if (![delegate respondsToSelector:@selector(collectionView:layout:didSectionHeaderPinToVisibleBounds:)]
                || ![delegate collectionView:self.collectionView layout:self didSectionHeaderPinToVisibleBounds:section]) {
                continue;
            }
            
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemsInSection-1) inSection:section];
            UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes;
            if (numberOfItemsInSection > 0) {
                firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            }
            else {
                firstItemAttributes = [UICollectionViewLayoutAttributes new];
                CGFloat y = CGRectGetMaxY(attributes.frame)+self.sectionInset.top;
                firstItemAttributes.frame = CGRectMake(0, y, 0, 0);
                lastItemAttributes = firstItemAttributes;
            }


            CGRect rect = attributes.frame;
            CGFloat offset = self.collectionView.contentOffset.y + self.headerVisibleBoundsOffset;
            CGFloat headerY = firstItemAttributes.frame.origin.y - rect.size.height - self.sectionInset.top;
            CGFloat maxY = MAX(offset,headerY);
            CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame) + self.sectionInset.bottom - rect.size.height;
            rect.origin.y = MIN(maxY,headerMissingY);
            attributes.frame = rect;
            attributes.zIndex = 7;
        }
    }
}

/// 修改section背景色
- (void)p_layoutBackgrounColorAttributes:(NSMutableArray *)superArray forElementsInRect:(CGRect)rect
{
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttributes) {
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [superArray addObject:attr];
        }
    }
}

#pragma mark - # Getter
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewAttributes
{
    if (!_decorationViewAttributes) {
        _decorationViewAttributes = [[NSMutableArray alloc] init];
    }
    return _decorationViewAttributes;
}

@end
