//
//  EDJListViewCell.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJListObjects.h"

@interface EDJTableListViewCell : UITableViewCell
{
@protected
    EDJListObject *_model;
}

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *txtLabel;
@property (nonatomic, strong) UILabel *detailTxtLabel;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) EDJListObject *model;
- (void)resetModel:(EDJListObject *)model;
- (void)resetContent:(id)content;
- (NSArray *)keypaths;
- (void)onModelChanged:(NSString *)keyPath old:(id)oldValue new:(id)newValue;
@end
