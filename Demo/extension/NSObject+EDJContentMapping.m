//
//  EDJContentObject.m
//  Demo
//
//  Created by 刘杨 on 2019/11/8.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSObject+EDJContentMapping.h"

@implementation NSObject (EDJContentMapping)

+ (instancetype)mappingObjectWithContent:(id)content{
    if ([self instancesRespondToSelector:@selector(setContent:)]) {
        NSObject<EDJContentObject> *object = [[self alloc] init];
        object.content = content;
        return object;
    }
    return nil;
}

- (id<EDJContentObject>)mappingObjectWithClass:(Class)cls{
    if ([cls instancesRespondToSelector:@selector(setContent:)]) {
        id<EDJContentObject> object = [[cls alloc] init];
        return [self mappingContentWithObject:object];
    }
    return nil;
}

- (id<EDJContentObject>)mappingContentWithObject:(id<EDJContentObject>)object{
    object.content = self;
    return object;
}

@end

