//
//  EDJListObjectAction.h
//  Demo
//
//  Created by 刘杨 on 2020/1/22.
//  Copyright © 2020 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EDJListObjectAction : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UITableViewCellEditingStyle style;
@property (nonatomic, assign) UITableViewRowActionStyle rowStyle;
@property (nonatomic, assign) UIContextualActionStyle actionStyle;
@end
