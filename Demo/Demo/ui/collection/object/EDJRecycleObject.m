//
//  EDJRecycleObject.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import "EDJRecycleObject.h"
#import "EDJCollectionRecycleCell.h"

@implementation EDJRecycleObject

- (instancetype)init{
    self = [super init];
    _viewClass = [EDJCollectionRecycleCell class];
    return self;
}

- (void)calculateSetSize:(CGSize)size{
    _size = size;
}

//优化kvo，这里通知完obv后要及时释放变量
- (void)setNotify:(id)notify{
    NSString *key = NSStringFromSelector(@selector(notify));
    [self willChangeValueForKey:key];
    _notify = notify;
    [self didChangeValueForKey:key];
    _notify = nil;
}

- (NSIndexPath *)indexPath{
    return [NSIndexPath indexPathForItem:_item inSection:_section];
}
@end
