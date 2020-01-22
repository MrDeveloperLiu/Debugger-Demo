//
//  EDJOrderRecycleAttributes.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/26.
//

#import <UIKit/UIKit.h>

@interface EDJOrderRecycleAttributes : UICollectionViewLayoutAttributes

@end

@interface EDJOrderRecycleSections : NSObject
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger itemsCount;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) NSMutableArray <EDJOrderRecycleAttributes *> *items;
@property (nonatomic, assign) BOOL hidden;
@end

