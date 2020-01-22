//
//  EDJListHeaderFooterObject.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+EDJContentMapping.h"

@class EDJListHeaderFooterObject;

@protocol EDJListHeaderFooterObjectDelegate <NSObject>
@optional
- (void)listHeaderFooterObject:(EDJListHeaderFooterObject *)object performSelector:(NSString *)selector userinfo:(id)userinfo;
@end

@interface EDJListHeaderFooterObject : NSObject <EDJContentObject>
@property (nonatomic, weak) id<EDJListHeaderFooterObjectDelegate> UIDelegate;

@property (nonatomic, strong) id content;
@property (nonatomic, strong) Class viewClass;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) CGFloat height;

@end
