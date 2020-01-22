//
//  EDJListObjectAction.m
//  Demo
//
//  Created by 刘杨 on 2020/1/22.
//  Copyright © 2020 liu. All rights reserved.
//

#import "EDJListObjectAction.h"

@implementation EDJListObjectAction

- (instancetype)init{
    self = [super init];
    _style = UITableViewCellEditingStyleInsert;
    _rowStyle = UITableViewRowActionStyleDefault;
    if (@available(iOS 11.0, *)) {
        _actionStyle = UIContextualActionStyleNormal;
    }
    return self;
}

@end
