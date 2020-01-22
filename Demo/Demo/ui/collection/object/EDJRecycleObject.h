//
//  EDJRecycleObject.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import <Foundation/Foundation.h>
#import "NSObject+EDJContentMapping.h"

@class EDJRecycleObject;

@protocol EDJRecycleObjectDelegate <NSObject>
//需要重新布局
- (void)recycleObject:(EDJRecycleObject *)object needResizeLayoutWithAction:(NSInteger)action;
//需要执行某个操作
- (void)recycleObject:(EDJRecycleObject *)object willPerformSelector:(NSString *)selector userinfo:(id)userinfo;
@end

typedef NS_ENUM(NSUInteger, EDJRecycleObjectLine) {
    EDJRecycleObjectLineNone = 0,
    EDJRecycleObjectLineLeft,
    EDJRecycleObjectLineRight,
    EDJRecycleObjectLineTop,
    EDJRecycleObjectLineBottom
};

@interface EDJRecycleObject : NSObject <EDJContentObject>
@property (nonatomic, strong) id content;
//获取字段
@property (nonatomic, copy) NSString *taken;
//监听字段
@property (nonatomic, strong) id event;
//messageSend
@property (nonatomic, copy) NSString *messageSend;
//actionSend
@property (nonatomic, copy) NSString *actionSend;
//信息字段
@property (nonatomic, strong) id info;
//拓展字段
@property (nonatomic, strong) id extra;
//预留字段
@property (nonatomic, strong) id reserved0;
@property (nonatomic, strong) id reserved1;
@property (nonatomic, strong) id reserved2;
@property (nonatomic, strong) id reserved3;
@property (nonatomic, strong) id reserved4;
//通知字段
@property (nonatomic, strong) id notify;
//描述view字段
@property (nonatomic, strong) Class viewClass;
@property (nonatomic, assign) CGSize viewSize;
//状态字段
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign) EDJRecycleObjectLine seperateLine;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) BOOL selected;
//靠开发者保证这个section对应元素集合section
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger item;
//弱引用view
@property (nonatomic, weak) id<EDJRecycleObjectDelegate> delegate;

- (void)calculateSetSize:(CGSize)size;

- (NSIndexPath *)indexPath;
@end

