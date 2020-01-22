//
//  EDJCollectionRecycleView.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import "EDJCollectionRecycleView.h"

@implementation EDJCollectionRecycleView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.backgroundColor = [UIColor clearColor];
    if (@available(iOS 10.0, *)) {
        self.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    [self registerCellWithClass:[EDJCollectionRecycleCell class]];
    return self;
}

- (void)registerCellWithClass:(Class)cls{
    if (cls == NULL) {
        return;
    }
    [self registerClass:cls forCellWithReuseIdentifier:NSStringFromClass(cls)];
}

- (void)registerViewWithClass:(Class)cls kind:(NSString *)kind{
    if (cls == NULL) {
        return;
    }
    [self registerClass:cls forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(cls)];
}

@end
