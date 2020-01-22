//
//  EDJContentObject.h
//  Demo
//
//  Created by 刘杨 on 2019/11/8.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol EDJContentObject <NSObject>
@property (nonatomic, strong) id content;
@end

@protocol EDJContentMapping <NSObject>
+ (instancetype)mappingObjectWithContent:(id)content;
- (id<EDJContentObject>)mappingObjectWithClass:(Class)cls;
- (id<EDJContentObject>)mappingContentWithObject:(id<EDJContentObject>)object;
@end

@interface NSObject (EDJContentMapping) <EDJContentMapping>

@end

