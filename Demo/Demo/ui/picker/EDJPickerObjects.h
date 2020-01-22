//
//  EDJPickerObjects.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/11.
//

#import <Foundation/Foundation.h>
#import "EDJPickerObject.h"

@interface EDJPickerObjects : NSObject
@property (nonatomic, assign) NSInteger component;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, weak) EDJPickerObject *selectObject;
@end
