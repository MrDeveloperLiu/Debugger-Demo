//
//  EDJOrderRecycleLayout.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/26.
//

#import "EDJOrderRecycleLayout.h"

@implementation EDJOrderRecycleLayout

- (void)prepareLayout{
    [self _layout];
    [self _layoutSize];
    [super prepareLayout];
    [self _finish];
}

- (void)_layout{
    NSInteger sections = [self.collectionView numberOfSections];
    if (sections <= 0) {
        return;
    }
    NSMutableArray *attributes = [NSMutableArray array];
    NSMutableArray *its = [NSMutableArray array];
    
    EDJOrderRecycleSections *previous = nil;
    
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger counts = [self.collectionView numberOfItemsInSection:i];
        EDJOrderRecycleSections *items = [self layoutSection:i counts:counts];
        [self layoutItemWithItems:items previous:previous];
        [attributes addObjectsFromArray:items.items];
        [its addObject:items];
        previous = items;
    }
    
    self.attributes = attributes;
    self.sections = its;
}

- (EDJOrderRecycleSections *)layoutSection:(NSInteger)section counts:(NSInteger)counts{
    EDJOrderRecycleSections *items = [EDJOrderRecycleSections new];
    items.section = section;
    items.itemsCount = counts;
    return items;
}

- (void)layoutItemWithItems:(EDJOrderRecycleSections *)sections previous:(EDJOrderRecycleSections *)previous{
 
    EDJOrderRecycleAttributes *previousLastItem = previous.items.lastObject;
    EDJOrderRecycleAttributes *previousItem = previousLastItem;
    BOOL oneLess = NO;
    for (int i = 0; i < sections.itemsCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:sections.section];

        BOOL hidden = [self _layoutItemHiddenWithIndexPath:indexPath];
        CGSize size = [self _layoutItemSizeWithIndexPath:indexPath];
        
        CGFloat x = 0, y = 0;
        CGFloat w = size.width;
        CGFloat h = size.height;
        
        if (0 == indexPath.item) {  //第一个
            if (previous.hidden) { //前一组都隐藏
                y = CGRectGetMinY(previousItem.frame);
            }else{
                y = CGRectGetMaxY(previousItem.frame);
            }
        }else{                      //非第一个, 同组
            y = CGRectGetMinY(previousItem.frame);
            // 隐藏 or 前一个元素隐藏 让其展示在这个元素下面
            /*
            if (previousItem.zIndex == 0 || hidden) {
                x = CGRectGetMinX(previousItem.frame);
            }else{
                x = CGRectGetMaxX(previousItem.frame);
            }
             */
            //fix: 2019-12-17 15:02:37
            if (previousItem.zIndex == 0) {
                if (hidden) {
                    x = CGRectGetMinX(previousItem.frame);
                }else{
                    x = CGRectGetMaxX(previousItem.frame);
                }
            }else{
                if (hidden) {
                    x = CGRectGetMinX(previousItem.frame);
                }else{
                    x = CGRectGetMaxX(previousItem.frame);
                }
            }
        }
        
        EDJOrderRecycleAttributes *attribute = [EDJOrderRecycleAttributes layoutAttributesForCellWithIndexPath:indexPath];
        if (hidden) {//依靠z轴和透明度解决隐藏展示问题(保证view被前一个view遮盖住)，高度重置为最小高度
            h = 50;
            attribute.zIndex = 0;
            attribute.alpha = 0;
        }else{
            if (!oneLess) { //找出一个没有隐藏的
                oneLess = YES;
            }
            attribute.zIndex = 1;
            attribute.alpha = 1;
        }
        CGRect frame = CGRectMake(x, y, w, h);
        attribute.frame = frame;
        [sections.items addObject:attribute];

        previousItem = attribute;
    }
    EDJOrderRecycleAttributes *firstItem = sections.items.firstObject;
    //计算
    CGRect rect;
    rect.origin = firstItem.frame.origin;
    rect.size = CGSizeMake(CGRectGetMaxX(previousItem.frame) - rect.origin.x,
                           CGRectGetMaxY(previousItem.frame) - rect.origin.y);
    sections.rect = rect;
    sections.hidden = !oneLess;
}


- (BOOL)_layoutItemHiddenWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(recycleLayout:itemHiddenAtIndexPath:)]) {
        return [self.delegate recycleLayout:self itemHiddenAtIndexPath:indexPath];
    }
    return NO;
}


- (CGSize)_layoutItemSizeWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(recycleLayout:itemSizeAtIndexPath:)]) {
        return [self.delegate recycleLayout:self itemSizeAtIndexPath:indexPath];
    }
    return _itemSize;
}

- (void)_layoutSize{
    UICollectionViewLayoutAttributes *last = self.attributes.lastObject;
    _viewSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame),
                           CGRectGetMaxY(last.frame));
}

- (void)_finish{
    if ([self.delegate respondsToSelector:@selector(recycleLayoutDidFinished:)]) {
        [self.delegate recycleLayoutDidFinished:self];
    }
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = self.attributes;
    return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    EDJOrderRecycleAttributes *attribute = [self.attributes objectAtIndex:indexPath.item];
    return attribute;
}

- (CGSize)collectionViewContentSize{
    return _viewSize;
}


@end
