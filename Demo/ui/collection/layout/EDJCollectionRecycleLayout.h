//
//  EDJCollectionRecycleLayout.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import <UIKit/UIKit.h>

@class EDJCollectionRecycleLayout;

typedef NS_ENUM(NSUInteger, EDJCollectionRecycleLayoutDirection) {
    EDJCollectionRecycleLayoutDirectionHorizontal,
    EDJCollectionRecycleLayoutDirectionVertical,
};

@protocol EDJCollectionRecycleLayoutDelegate <NSObject>
@optional
- (CGSize)recycleLayout:(EDJCollectionRecycleLayout *)lt itemSizeAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)recycleLayout:(EDJCollectionRecycleLayout *)lt itemSpacingAtIndexPath:(NSIndexPath *)indexPath;
- (void)recycleLayoutDidFinished:(EDJCollectionRecycleLayout *)lt;
@end

@interface EDJCollectionRecycleLayout : UICollectionViewLayout
@property (nonatomic, weak) id<EDJCollectionRecycleLayoutDelegate> delegate;
@property (nonatomic, assign) EDJCollectionRecycleLayoutDirection direction;
@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, assign, readonly) CGSize viewSize;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) BOOL defineSize;

- (void)_layout;
- (UICollectionViewLayoutAttributes *)_layoutAttributesWithIndexPath:(NSIndexPath *)indexPath previous:(UICollectionViewLayoutAttributes *)previous;
- (void)_layoutSize;
- (void)_finish;
@end
