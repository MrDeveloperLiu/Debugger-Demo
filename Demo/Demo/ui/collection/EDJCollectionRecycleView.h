//
//  EDJCollectionRecycleView.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import <UIKit/UIKit.h>
#import "EDJCollectionRecycleDatasource.h"
#import "EDJCollectionRecycleLayout.h"
#import "EDJOrderRecycleLayout.h"

@interface EDJCollectionRecycleView : UICollectionView

- (void)registerCellWithClass:(Class)cls;
- (void)registerViewWithClass:(Class)cls kind:(NSString *)kind;
@end
