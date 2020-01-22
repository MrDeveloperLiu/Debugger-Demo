//
//  EDJCollectionRecycleDatasource.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import "EDJCollectionRecycleDatasource.h"

@implementation EDJCollectionRecycleDatasource

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView delegate:(id)delegate{
    self = [super init];
    _selectLimit = 1;
    _selects = [NSMutableArray array];
    _collectionView = collectionView;
    _collectionView.dataSource = self;
    self.delegate = delegate;
    return self;
}

- (void)setDelegate:(id)delegate{
    _delegate = delegate;
    if (delegate) {
        _collectionView.delegate = delegate;
    }else{
        _collectionView.delegate = self;
    }
}

- (void)setSections:(NSMutableArray *)sections{
    if (_sections != sections) {
        _sections = sections;
        [self.collectionView reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    EDJRecycleObjects *items = [self itemsAtSection:section];
    return items.cells.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EDJRecycleObject *model = [self itemAtIndexPath:indexPath];
    NSParameterAssert(model.viewClass);
    NSString *identifier = NSStringFromClass(model.viewClass);
    EDJCollectionRecycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                               forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    if (0 == (_option & EDJRecycleDatasourceOptionDisableSelect)) {
        EDJRecycleObject *model = [self itemAtIndexPath:indexPath];
        if ([self.selects containsObject:model]) {
            if ((_option & EDJRecycleDatasourceOptionDisableCancelSelect)) {
                if ([self.dsDelegate respondsToSelector:@selector(recycleDatasource:didTapItemAtIndexPath:)]) {
                    [self.dsDelegate recycleDatasource:self didTapItemAtIndexPath:indexPath];
                }
                return;
            }
            model.selected = NO;
            [self.selects removeObject:model];
            
            if ([self.dsDelegate respondsToSelector:@selector(recycleDatasource:didDeselectedItemAtIndexPath:)]) {
                [self.dsDelegate recycleDatasource:self didDeselectedItemAtIndexPath:indexPath];
            }
        }else{

            NSInteger limit = self.selectLimit;
            NSInteger count = self.selects.count;
            if (limit > 0 && count >= limit) {//FIFO
                EDJRecycleObject *remove = [self.selects objectAtIndex:0];
                [self.selects removeObjectAtIndex:0];
                remove.selected = NO;
                
                if ([self.dsDelegate respondsToSelector:@selector(recycleDatasource:didDeselectedItemAtIndexPath:)]) {
                    [self.dsDelegate recycleDatasource:self didDeselectedItemAtIndexPath:indexPath];
                }
            }

            model.selected = YES;
            [self.selects addObject:model];
            
            if ([self.dsDelegate respondsToSelector:@selector(recycleDatasource:didSelectedItemAtIndexPath:)]) {
                [self.dsDelegate recycleDatasource:self didSelectedItemAtIndexPath:indexPath];
            }
        }
    }else{
        if ([self.dsDelegate respondsToSelector:@selector(recycleDatasource:didTapItemAtIndexPath:)]) {
            [self.dsDelegate recycleDatasource:self didTapItemAtIndexPath:indexPath];
        }
    }
}

- (EDJRecycleObject *)itemAtIndexPath:(NSIndexPath *)indexPath{
    EDJRecycleObjects *items = [self itemsAtSection:indexPath.section];
    EDJRecycleObject *item = [items.cells objectAtIndex:indexPath.item];
    return item;
}

- (EDJRecycleObjects *)itemsAtSection:(NSInteger)section{
    EDJRecycleObjects *items = [_sections objectAtIndex:section];
    return items;
}


- (NSIndexPath *)indexPathForItem:(EDJRecycleObject *)item{
    EDJRecycleObjects *objects = [_sections objectAtIndex:item.section];
    NSInteger index = [objects.cells indexOfObject:item];
    if (index != NSNotFound) {
        return [NSIndexPath indexPathForItem:index inSection:item.section];
    }
    return nil;
}

@end
