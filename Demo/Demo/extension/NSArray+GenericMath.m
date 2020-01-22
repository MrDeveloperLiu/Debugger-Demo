//
//  NSArray+EDJTransformable.m
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSArray+GenericMath.h"



@implementation NSArray (GenericMath)

- (NSMutableArray *)containerMap:(EDJGenericMathBlock)usingBlock{
    return [self map:^id(id object, id container){
        if (container) {
            return [container containerMap:usingBlock];
        }
        return usingBlock(object);
    }];
}

- (NSMutableArray *)map:(EDJGenericMathMapBlock)usingBlock{
    return [self indexMap:^id(id object, id container, NSUInteger idx, BOOL *stop) {
        return usingBlock(object, container);
    }];
}

- (NSMutableArray *)indexMap:(EDJGenericMathIndexMapBlock)usingBlock{
    NSInteger count = self.count;
    if (count <= 0) {
        return nil;
    }
    NSMutableArray *temp = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @autoreleasepool {
            id value = nil;
            if ([obj isKindOfClass:[NSArray class]]) {
                value = usingBlock(nil, obj, idx, stop);
            }else{
                value = usingBlock(obj, nil, idx, stop);
            }
            if (value) {
                [temp addObject:value];
            }
        }
    }];
    return temp;

}
@end

