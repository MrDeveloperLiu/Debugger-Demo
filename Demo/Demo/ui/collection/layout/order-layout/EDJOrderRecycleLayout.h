//
//  EDJOrderRecycleLayout.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/26.
//

#import "EDJCollectionRecycleLayout.h"
#import "EDJOrderRecycleAttributes.h"

@class EDJOrderRecycleLayout;

@protocol EDJOrderRecycleLayoutDelegate <NSObject>
@optional
- (BOOL)recycleLayout:(EDJOrderRecycleLayout *)lt itemHiddenAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)recycleLayout:(EDJOrderRecycleLayout *)lt itemSizeAtIndexPath:(NSIndexPath *)indexPath;
- (void)recycleLayoutDidFinished:(EDJOrderRecycleLayout *)lt;
@end

@interface EDJOrderRecycleLayout : UICollectionViewLayout
@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, assign, readonly) CGSize viewSize;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, weak) id<EDJOrderRecycleLayoutDelegate> delegate;
@end
