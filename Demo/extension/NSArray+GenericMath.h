//
//  NSArray+EDJTransformable.h
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef id(^EDJGenericMathBlock)(id object);
typedef id(^EDJGenericMathMapBlock)(id object, id container);
typedef id(^EDJGenericMathIndexMapBlock)(id object, id container, NSUInteger idx, BOOL *stop);

@interface NSArray (GenericMath)

- (NSMutableArray *)containerMap:(EDJGenericMathBlock)usingBlock;

- (NSMutableArray *)map:(EDJGenericMathMapBlock)usingBlock;

- (NSMutableArray *)indexMap:(EDJGenericMathIndexMapBlock)usingBlock;
@end


