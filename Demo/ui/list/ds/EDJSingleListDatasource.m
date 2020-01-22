//
//  EDJTableDatasource.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJSingleListDatasource.h"

@implementation EDJSingleListDatasource

- (void)setDatas:(NSMutableArray *)datas{
    if (_datas != datas) {
        _datas = datas;
        [self.tableView reloadData];
    }
}

- (void)appendDatas:(NSMutableArray *)datas{
    if ([datas isKindOfClass:[NSMutableArray class]]) {
        if ([_datas isKindOfClass:[NSMutableArray class]]) {
            [_datas addObjectsFromArray:datas];
        }else{
            _datas = datas;
        }
        [self.tableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
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
    if (self.footer) {
        Class class = self.footer.viewClass;
        NSParameterAssert(class);
        NSString *identifier = NSStringFromClass(class);
        EDJTableListHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!view) {
            view = [[class alloc] initWithReuseIdentifier:identifier];
        }
        view.model = self.footer;
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.header) {
        Class class = self.header.viewClass;
        NSParameterAssert(class);
        NSString *identifier = NSStringFromClass(class);
        EDJTableListHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!view) {
            view = [[class alloc] initWithReuseIdentifier:identifier];
        }
        view.model = self.header;
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.footer.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.header.height;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    return model.rowHeight;
}

- (EDJListObject *)itemAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [_datas objectAtIndex:indexPath.row];
    return model;
}

- (NSIndexPath *)indexPathForItem:(EDJListObject *)item{
    if (!item) {
        return nil;
    }
    NSInteger index = [_datas indexOfObject:item];
    if (index != NSNotFound) {
        return [NSIndexPath indexPathForRow:index inSection:0];
    }
    return nil;
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath{
    [_datas removeObjectAtIndex:indexPath.row];
}
@end

