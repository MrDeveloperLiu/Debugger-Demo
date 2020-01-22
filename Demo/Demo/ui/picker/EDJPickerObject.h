//
//  EDJPickerObject.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/11.
//

#import <Foundation/Foundation.h>
#import "NSObject+EDJContentMapping.h"

@class EDJPickerObject;

@protocol EDJPickerObjectProtocol <NSObject>
@property (nonatomic, strong) EDJPickerObject *model;
@end

@interface EDJPickerObjectPair : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) id value;
- (instancetype)initWithTitle:(NSString *)title value:(id)value;
+ (instancetype)pairWithTitle:(NSString *)title value:(id)value;
@end

@interface EDJPickerObject : NSObject <EDJContentObject>
@property (nonatomic, assign) NSInteger component; //靠开发者保证这个component对应元素集合component
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) id content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSAttributedString *attributeTitle;

@property (nonatomic, strong) Class<EDJPickerObjectProtocol> viewClass;
@end


