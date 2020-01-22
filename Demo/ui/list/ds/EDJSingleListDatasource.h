//
//  EDJTableDatasource.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJBaseListDatasource.h"

@interface EDJSingleListDatasource : EDJBaseListDatasource
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) EDJListHeaderFooterObject *header;
@property (nonatomic, strong) EDJListHeaderFooterObject *footer;

- (void)appendDatas:(NSMutableArray *)datas;
@end


