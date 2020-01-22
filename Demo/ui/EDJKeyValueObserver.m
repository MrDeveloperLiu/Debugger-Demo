//
//  EDJKeyValueObserver.m
//  edaijia
//
//  Created by liuyang on 2018/8/9.
//

#import "EDJKeyValueObserver.h"
#import <objc/runtime.h>

@interface EDJKeyValueObserver ()
@property (nonatomic, copy) EDJKeyValueObserverChangedBlock block;
@property (nonatomic, assign) BOOL observered;
@end

@implementation EDJKeyValueObserver

- (void)dealloc{
    _block = nil;
    if (_observered) {
        [self finished];
    }
    _keyPaths = nil;
    _observered = NO;
}

- (instancetype)initWithTarget:(id)target keypath:(NSArray <NSString *>*)keypath changed:(EDJKeyValueObserverChangedBlock)changed{
    self = [super init];
    if (self) {
        _target = target;
        _block = changed;
        
        if (!keypath) {
            _keyPaths = [self loadTargetKeypaths];
        }else{
            _keyPaths = keypath;
        }
    }
    return self;
}

- (void)beigin{
    [_keyPaths enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self observeKeypath:obj];
    }];
    _observered = YES;
}

- (void)finished{
    [_keyPaths enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self reomveKeypath:obj];
    }];
    _observered = NO;
}

- (NSArray *)loadTargetKeypaths{
    return [self edj_runtimePropertiesList];
}

- (NSMutableArray *)edj_runtimePropertiesList{
    NSMutableArray *retVal = @[].mutableCopy;
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *propertyChar = property_getName(property);
        if (propertyChar == NULL) continue;
        
        NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
        [retVal addObject:propertyName];
    }
    if (properties != NULL) {
        free(properties);
    }
    return retVal;
}

- (void)observeKeypath:(NSString *)keypath{
    @try {
        [_target addObserver:self forKeyPath:keypath options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:NULL];
    }
    @catch (NSException *e){
        NSLog(@"[ERROR]: observeKeypath: %@", e);
    }
}
- (void)reomveKeypath:(NSString *)keypath{
    @try {
        [_target removeObserver:self forKeyPath:keypath];
    }
    @catch (NSException *e){
        NSLog(@"[ERROR]: reomveKeypath: %@", e);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (![_keyPaths containsObject:keyPath]) {
        return;
    }
    id old = [change objectForKey:NSKeyValueChangeOldKey];
    id new = [change objectForKey:NSKeyValueChangeNewKey];
    if (old == new || !_block) {
        return;
    }
    self.block(keyPath, old, new);
}

@end


























