//
//  EDJMultiListDatasource.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//
#import "EDJBaseListDatasource.h"

@interface EDJMultiListDatasource : EDJBaseListDatasource
@property (nonatomic, strong) NSMutableArray *sections;

- (void)setDatas:(NSMutableArray *)datas withSection:(NSInteger)section;
- (void)appendDatas:(NSMutableArray *)datas withSection:(NSInteger)section;

- (EDJListObjects *)sectionAtIndexPath:(NSIndexPath *)indexPath;
- (EDJListObjects *)sectionAtIndex:(NSUInteger)index;
@end


@interface EDJMultiListDatasource (Indeces)
@end
