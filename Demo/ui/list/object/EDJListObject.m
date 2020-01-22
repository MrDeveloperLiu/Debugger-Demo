//
//  EDJListObject.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJListObject.h"
#import "EDJTableListViewCell.h"

@implementation EDJListObject

- (instancetype)init{
    self = [super init];
    _rowHeight = 44;
    _viewClass = [EDJTableListViewCell class];
    return self;
}

- (NSIndexPath *)indexPath{
    return [NSIndexPath indexPathForRow:_row inSection:_section];
}
@end


@implementation EDJListObject (Action)

- (UITableViewCellEditingStyle)editingStyle{
    if (self.actions.count <= 0) {
        return UITableViewCellEditingStyleNone;
    }
    UITableViewCellEditingStyle style = 0;
    for (EDJListObjectAction *action in self.actions) {
        style |= action.style;
    }
    return style;
}

- (NSArray<UITableViewRowAction *> *)editingRowActions{
    if (self.actions.count <= 0) {
        return nil;
    }
    __weak __typeof(self) ws = self;
    NSMutableArray *temp = [NSMutableArray array];
    for (EDJListObjectAction *act in self.actions) {
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:act.rowStyle
                                                                                title:act.title
                                                                              handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            [ws.UIDelegate listObject:ws performAction:act.Id action:act];
        }];
        [temp addObject:deleteAction];
    }
    return temp;
}

- (UISwipeActionsConfiguration *)editingConfiguration API_AVAILABLE(ios(11.0)){
    if (self.actions.count <= 0) {
        return nil;
    }
    __weak __typeof(self) ws = self;
    NSMutableArray *temp = [NSMutableArray array];
    for (EDJListObjectAction *act in self.actions) {
        UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:act.actionStyle
                                                                                   title:act.title
                                                                                 handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
            [ws.UIDelegate listObject:ws performAction:act.Id action:act];
            completionHandler(YES);
        }];
        [temp addObject:deleteAction];
    }
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:temp];
    config.performsFirstActionWithFullSwipe = NO;
    return config;
}

@end

