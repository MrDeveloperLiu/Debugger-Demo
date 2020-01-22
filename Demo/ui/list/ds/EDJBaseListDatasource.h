//
//  EDJBaseListDatasource.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/11.
//

#import <Foundation/Foundation.h>
#import "EDJTableListViewCell.h"
#import "EDJTableListHeaderFooterView.h"

@class EDJBaseListDatasource;

typedef NS_OPTIONS(NSUInteger, EDJBaseListDatasourceOption) {
    EDJBaseListDatasourceOptionDisableSelect = 1 << 0,
    EDJBaseListDatasourceOptionDisableCancelSelect = 1 << 1,
    EDJBaseListDatasourceOptionSelectUsingBlock = 1 << 2,
};

@protocol EDJBaseListDatasourceDelegate <NSObject>
@optional
- (void)listDatasource:(EDJBaseListDatasource *)ds didSelectedObjectAtIndexPath:(NSIndexPath *)indexPath;
- (void)listDatasource:(EDJBaseListDatasource *)ds didDeselectedObjectAtIndexPath:(NSIndexPath *)indexPath;
- (void)listDatasource:(EDJBaseListDatasource *)ds didTappedObjectAtIndexPath:(NSIndexPath *)indexPath;
@end

typedef void (^EDJBaseListDatasourceBlock)(EDJBaseListDatasource *ds, NSIndexPath *indexPath);

@interface EDJBaseListDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id <EDJBaseListDatasourceDelegate> UIDelegate;

@property (nonatomic, strong) NSMutableArray *selects;
@property (nonatomic, assign) NSInteger selectLimit;
@property (nonatomic, assign) EDJBaseListDatasourceOption option;
@property (nonatomic, copy) EDJBaseListDatasourceBlock selectBlock;

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<EDJBaseListDatasourceDelegate>)delegate;
- (EDJListObject *)itemAtIndexPath:(NSIndexPath *)indexPath;

- (void)clearSelect;

- (void)selectObject:(EDJListObject *)object;
- (void)deselectObject:(EDJListObject *)object;

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface EDJBaseListDatasource (Edit)
@end
