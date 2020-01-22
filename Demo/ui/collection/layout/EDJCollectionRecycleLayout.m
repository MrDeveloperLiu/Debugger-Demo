//
//  EDJCollectionRecycleLayout.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import "EDJCollectionRecycleLayout.h"

@interface EDJCollectionRecycleLayout ()
@property (nonatomic, assign) CGSize maxLayoutSize;
@end

@implementation EDJCollectionRecycleLayout

- (instancetype)init{
    self = [super init];
    _direction = EDJCollectionRecycleLayoutDirectionVertical;
    _itemSize = CGSizeMake(44, 44);
    if ([UIScreen mainScreen].scale <= 2) {
        _spacing = 0.5;
    }else{
        _spacing = 0.33;
    }
    return self;
}

- (void)dealloc{

}

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
    _maxLayoutSize = CGSizeZero;
    UICollectionViewLayoutAttributes *previous = nil;
    NSMutableArray *temp = [NSMutableArray array];
    for (int section = 0; section < sections; section++) {
        NSUInteger items = [self.collectionView numberOfItemsInSection:section];
        for (int item = 0; item < items; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attribute = [self _layoutAttributesWithIndexPath:indexPath
                                                                                      previous:previous];
            [temp addObject:attribute];
            _maxLayoutSize = CGSizeMake(
                                        MAX(_maxLayoutSize.width, CGRectGetWidth(attribute.frame)),
                                        MAX(_maxLayoutSize.height, CGRectGetHeight(attribute.frame))
                                        );
            previous = attribute;
        }
    }
    self.attributes = temp;
}

- (UICollectionViewLayoutAttributes *)_layoutAttributesWithIndexPath:(NSIndexPath *)indexPath previous:(UICollectionViewLayoutAttributes *)previous{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat x = 0, y = 0, w = 0, h = 0;
    CGSize size = [self _layoutItemSizeWithIndexPath:indexPath];
    CGFloat spacing = [self _layoutItemSpacingWithIndexPath:indexPath];
    if (_direction == EDJCollectionRecycleLayoutDirectionHorizontal) {
        x = CGRectGetMaxX(previous.frame) + spacing;
        y = 0;
        w = size.width;
        if (_defineSize) {
            h = size.height > 0 ? size.height : CGRectGetHeight(self.collectionView.frame);
        }else{
            h = CGRectGetHeight(self.collectionView.frame);
        }
    }else{
        x = 0;
        y = CGRectGetMaxY(previous.frame) + spacing;
        if (_defineSize) {
            w = size.width > 0 ? size.width : CGRectGetWidth(self.collectionView.frame);
        }else{
            w = CGRectGetWidth(self.collectionView.frame);
        }
        h = size.height;
    }
    attribute.frame = CGRectMake(x, y, w, h);
    return attribute;
}


- (CGSize)_layoutItemSizeWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(recycleLayout:itemSizeAtIndexPath:)]) {
        return [self.delegate recycleLayout:self itemSizeAtIndexPath:indexPath];
    }
    return _itemSize;
}

- (CGFloat)_layoutItemSpacingWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(recycleLayout:itemSpacingAtIndexPath:)]) {
        return [self.delegate recycleLayout:self itemSpacingAtIndexPath:indexPath];
    }
    return _spacing;
}


- (void)_layoutSize{
    UICollectionViewLayoutAttributes *last = self.attributes.lastObject;
    if (_direction == EDJCollectionRecycleLayoutDirectionHorizontal) {
        if (_defineSize) {
            _viewSize = CGSizeMake(CGRectGetMaxX(last.frame),
                                   _maxLayoutSize.height);
        }else{
            _viewSize = CGSizeMake(CGRectGetMaxX(last.frame),
                                   CGRectGetHeight(self.collectionView.frame));
        }
    }else{
        if (_defineSize) {
            _viewSize = CGSizeMake(_maxLayoutSize.width,
                                   CGRectGetMaxY(last.frame));
        }else{
            _viewSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame),
                                   CGRectGetMaxY(last.frame));
        }
    }
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
    UICollectionViewLayoutAttributes *attribute = [self.attributes objectAtIndex:indexPath.item];
    return attribute;
}

- (CGSize)collectionViewContentSize{
    return _viewSize;
}

@end
