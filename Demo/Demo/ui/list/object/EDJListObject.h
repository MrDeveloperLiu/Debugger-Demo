//
//  EDJListObject.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+EDJContentMapping.h"
#import "EDJListObjectAction.h"

@class EDJListObject;

@protocol EDJListObjectDelegate <NSObject>
@optional
- (void)listObject:(EDJListObject *)object performSelector:(NSString *)selector userinfo:(id)userinfo;
- (void)listObject:(EDJListObject *)object performAction:(NSString *)Id action:(EDJListObjectAction *)action;
@end

@interface EDJListObject : NSObject <EDJContentObject>
@property (nonatomic, weak) id<EDJListObjectDelegate> UIDelegate;

@property (nonatomic, strong) id content;

@property (nonatomic, strong) id extra;
@property (nonatomic, strong) id reserved0;
@property (nonatomic, strong) id reserved1;
@property (nonatomic, strong) id reserved2;
@property (nonatomic, strong) id reserved3;
@property (nonatomic, strong) id reserved4;

@property (nonatomic, strong) Class viewClass;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL opened;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) NSInteger section; 
@property (nonatomic, assign) NSInteger row;

@property (nonatomic, strong) NSArray *actions;

- (NSIndexPath *)indexPath;
@end

@interface EDJListObject (Action)
- (UITableViewCellEditingStyle)editingStyle;
- (NSArray<UITableViewRowAction *> *)editingRowActions;
- (UISwipeActionsConfiguration *)editingConfiguration API_AVAILABLE(ios(11.0));
@end
