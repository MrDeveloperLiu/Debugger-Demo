//
//  EDJBaseListDatasource.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/11.
//

#import "EDJBaseListDatasource.h"


@implementation EDJBaseListDatasource

- (void)dealloc{
    _selectBlock = nil;
}

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<EDJBaseListDatasourceDelegate>)delegate{
    self = [super init];
    _tableView = tableView;
    _tableView.dataSource = self;
    self.delegate = delegate;
    _selects = [NSMutableArray array];
    _selectLimit = 1;
    return self;
}

- (void)setDelegate:(id)delegate{
    if (delegate) {
        _tableView.delegate = delegate;
    }else{
        _tableView.delegate = self;
    }
}

- (EDJListObject *)itemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ((_option & EDJBaseListDatasourceOptionSelectUsingBlock) && self.selectBlock) {
        self.selectBlock(self, indexPath);
        return;
    }
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    if (0 == (_option & EDJBaseListDatasourceOptionDisableSelect)) {
        if ([self.selects containsObject:model]) {
            if ((_option & EDJBaseListDatasourceOptionDisableCancelSelect)) {
                if ([self.UIDelegate respondsToSelector:@selector(listDatasource:didTappedObjectAtIndexPath:)]) {
                    [self.UIDelegate listDatasource:self didTappedObjectAtIndexPath:indexPath];
                }
                return;
            }
            model.selected = NO;
            [self.selects removeObject:model];
            
            if ([self.UIDelegate respondsToSelector:@selector(listDatasource:didDeselectedObjectAtIndexPath:)]) {
                [self.UIDelegate listDatasource:self didDeselectedObjectAtIndexPath:indexPath];
            }
        }else{
            NSInteger limit = self.selectLimit;
            NSInteger count = self.selects.count;
            if (limit > 0 && count >= limit) {//FIFO
                EDJListObject *remove = [self.selects objectAtIndex:0];
                [self.selects removeObjectAtIndex:0];
                remove.selected = NO;
                                
                if ([self.UIDelegate respondsToSelector:@selector(listDatasource:didDeselectedObjectAtIndexPath:)]) {
                    [self.UIDelegate listDatasource:self didDeselectedObjectAtIndexPath:indexPath];
                }
            }
            model.selected = YES;
            [self.selects addObject:model];
            
            if ([self.UIDelegate respondsToSelector:@selector(listDatasource:didSelectedObjectAtIndexPath:)]) {
                [self.UIDelegate listDatasource:self didSelectedObjectAtIndexPath:indexPath];
            }
        }
    }else{
        if ([self.UIDelegate respondsToSelector:@selector(listDatasource:didTappedObjectAtIndexPath:)]) {
            [self.UIDelegate listDatasource:self didTappedObjectAtIndexPath:indexPath];
        }
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

}


- (NSIndexPath *)indexPathForItem:(EDJListObject *)item{
    return nil;
}

- (void)clearSelect{
    [self.selects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EDJListObject *object = obj;
        object.selected = NO;
    }];
    [self.selects removeAllObjects];
}

- (void)selectObject:(EDJListObject *)object{
    //这里不用回调代理，你自己就知道了
    if (![object isKindOfClass:[EDJListObject class]]) {
        return;
    }
    
    NSInteger limit = self.selectLimit;
    NSInteger count = self.selects.count;
    
    if (limit > 0 && count >= limit) {//FIFO
        EDJListObject *remove = [self.selects objectAtIndex:0];
        [self.selects removeObjectAtIndex:0];
        remove.selected = NO;
    }
    
    object.selected = YES;
    if (![self.selects containsObject:object]) {
        [self.selects addObject:object];
    }
}

- (void)deselectObject:(EDJListObject *)object{
    //这里不用回调代理，你自己就知道了
    if (![object isKindOfClass:[EDJListObject class]]) {
        return;
    }
    
    object.selected = NO;    
    if ([self.selects containsObject:object]) {
        [self.selects removeObject:object];
    }
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath{}
@end

@implementation EDJBaseListDatasource (Edit)

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    return [model editingStyle];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    return [model editingRowActions];
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)) {
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    return [model editingConfiguration];
}

@end

