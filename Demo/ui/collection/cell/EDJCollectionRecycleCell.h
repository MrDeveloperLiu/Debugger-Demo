//
//  EDJCollectionRecycleCell.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import <UIKit/UIKit.h>
#import "EDJRecycleObjects.h"

@interface EDJCollectionRecycleCell : UICollectionViewCell
{
@protected
    EDJRecycleObject *_model;
}
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *textLabel;

@property (nonatomic, strong) EDJRecycleObject *model;

- (void)resetModel:(EDJRecycleObject *)model;
- (void)resetContent:(id)content;

- (NSArray *)modelKeypaths;
- (void)onModelChanged:(NSString *)keyPath old:(id)oldValue new:(id)newValue;

- (NSArray *)contentKeypaths;
- (void)onContentChanged:(NSString *)keyPath old:(id)oldValue new:(id)newValue;

@end

