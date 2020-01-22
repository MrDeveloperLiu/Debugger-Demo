//
//  EDJCollectionRecycleDatasource.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import <Foundation/Foundation.h>
#import "EDJRecycleObjects.h"
#import "EDJCollectionRecycleCell.h"

typedef NS_OPTIONS(NSUInteger, EDJRecycleDatasourceOption) {
    EDJRecycleDatasourceOptionDisableSelect = 1 << 0,
    EDJRecycleDatasourceOptionDisableCancelSelect = 1 << 1,
};

@class EDJCollectionRecycleDatasource;

@protocol EDJCollectionRecycleDatasourceDelegate <NSObject>
@optional
- (void)recycleDatasource:(EDJCollectionRecycleDatasource *)ds didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)recycleDatasource:(EDJCollectionRecycleDatasource *)ds didDeselectedItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)recycleDatasource:(EDJCollectionRecycleDatasource *)ds didTapItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface EDJCollectionRecycleDatasource : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) id <EDJCollectionRecycleDatasourceDelegate> dsDelegate;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) id <UICollectionViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *selects;
@property (nonatomic, assign) NSInteger selectLimit;
@property (nonatomic, assign) EDJRecycleDatasourceOption option;
@property (nonatomic, strong) NSMutableArray *sections;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView delegate:(id)delegate;
- (EDJRecycleObject *)itemAtIndexPath:(NSIndexPath *)indexPath;
- (EDJRecycleObjects *)itemsAtSection:(NSInteger)section;
@end
