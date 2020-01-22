//
//  EDJMultiListDatasource.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJMultiListDatasource.h"

@implementation EDJMultiListDatasource

- (void)setSections:(NSMutableArray *)sections{
    if (_sections != sections) {
        _sections = sections;
        [self.tableView reloadData];
    }
}

- (void)setDatas:(NSMutableArray *)datas withSection:(NSInteger)section{
    EDJListObjects *objects = [_sections objectAtIndex:section];
    objects.cells = datas;
    [self.tableView reloadData];
}

- (void)appendDatas:(NSMutableArray *)datas withSection:(NSInteger)section{
    EDJListObjects *objects = [_sections objectAtIndex:section];
    if ([objects.cells isKindOfClass:[NSMutableArray class]]) {
        [objects.cells addObjectsFromArray:datas];
    }else{
        objects.cells = datas;
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    return objects.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    Class class = model.viewClass;
    NSParameterAssert(class);
    NSString *identifier = NSStringFromClass(class);
    EDJTableListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    if (objects.footer) {
        Class class = objects.footer.viewClass;
        NSParameterAssert(class);
        NSString *identifier = NSStringFromClass(class);
        EDJTableListHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!view) {
            view = [[class alloc] initWithReuseIdentifier:identifier];
        }
        objects.section = section;
        view.model = objects.footer;
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    if (objects.header) {
        Class class = objects.header.viewClass;
        NSParameterAssert(class);
        NSString *identifier = NSStringFromClass(class);
        EDJTableListHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!view) {
            view = [[class alloc] initWithReuseIdentifier:identifier];
        }
        objects.section = section;
        view.model = objects.header;
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    return model.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    return objects.footer.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    return objects.header.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (EDJListObjects *)sectionAtIndexPath:(NSIndexPath *)indexPath{
    return [self sectionAtIndex:indexPath.section];
}

- (EDJListObjects *)sectionAtIndex:(NSUInteger)index{
    EDJListObjects *objects = [_sections objectAtIndex:index];
    return objects;
}

- (EDJListObject *)itemAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObjects *objects = [_sections objectAtIndex:indexPath.section];
    EDJListObject *model = [objects.cells objectAtIndex:indexPath.row];
    return model;
}

- (NSIndexPath *)indexPathForItem:(EDJListObject *)item{
    EDJListObjects *objects = [_sections objectAtIndex:item.section];
    NSInteger index = [objects.cells indexOfObject:item];
    if (index != NSNotFound) {
        return [NSIndexPath indexPathForRow:index inSection:item.section];
    }
    return nil;
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObjects *objects = [self sectionAtIndexPath:indexPath];
    //先删除
    [objects.cells removeObjectAtIndex:indexPath.row];
    //在判断有无元素
    if (objects.cells.count <= 0) {
        [_sections removeObjectAtIndex:indexPath.section];
    }
}
@end


@implementation EDJMultiListDatasource (Indeces)

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.sections.count <= 0) {
        return nil;
    }
    if (self.option & EDJBaseListDatasourceOptionTitleIndeces) {
        NSMutableArray *temp = [NSMutableArray array];
        [self.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            EDJListObjects *objects = obj;
            if ([objects.index isKindOfClass:[NSString class]]) {
                [temp addObject:objects.index];
            }
        }];
        return temp;
    }
    return nil;
}

@end
