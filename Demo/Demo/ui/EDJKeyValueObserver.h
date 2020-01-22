//
//  EDJKeyValueObserver.h
//  edaijia
//
//  Created by liuyang on 2018/8/9.
//

#import <Foundation/Foundation.h>

typedef void(^EDJKeyValueObserverChangedBlock)(NSString *keyPath, id oldValue, id newValue);

@interface EDJKeyValueObserver : NSObject
//目前是弱引用, 所以必须保证该target release之前, 释放obv, 否则会造成crash.
//另方案: 强引用, 但是很可能引起使用不当引用循环
@property (nonatomic, weak) id target;
@property (nonatomic, strong) NSArray <NSString *>*keyPaths;

- (instancetype)initWithTarget:(id)target keypath:(NSArray <NSString *>*)keypath changed:(EDJKeyValueObserverChangedBlock)changed;

- (void)beigin;
- (void)finished;
@end
