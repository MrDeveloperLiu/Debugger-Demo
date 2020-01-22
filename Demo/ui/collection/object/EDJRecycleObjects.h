//
//  EDJRecycleObjects.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import <Foundation/Foundation.h>
#import "EDJRecycleObject.h"


@interface EDJRecycleObjects : NSObject
@property (nonatomic, assign) NSInteger section;

@property (nonatomic, strong) NSMutableArray <EDJRecycleObject *>*cells;
@property (nonatomic, strong) NSMutableArray <EDJRecycleObject *>*visiableCells;
@property (nonatomic, strong) NSMutableArray <EDJRecycleObject *>*invisiableCells;

@property (nonatomic, assign) CGSize maxSize;
//剩余宽度
@property (nonatomic, assign) CGFloat layoutWidth;
//需要自动布局的数量
@property (nonatomic, assign) NSInteger layoutCount;
@end


