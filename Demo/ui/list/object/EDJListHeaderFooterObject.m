//
//  EDJListHeaderFooterObject.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJListHeaderFooterObject.h"
#import "EDJTableListHeaderFooterView.h"

@implementation EDJListHeaderFooterObject

- (instancetype)init{
    self = [super init];
    _height = 20;
    _viewClass = [EDJTableListHeaderFooterView class];
    return self;
}

@end
