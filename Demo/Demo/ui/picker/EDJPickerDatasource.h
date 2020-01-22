//
//  EDJPickerDatasource.h
//  edaijia
//
//  Created by 刘杨 on 2019/11/11.
//

#import <Foundation/Foundation.h>
#import "EDJPickerObjects.h"

@interface EDJPickerDatasource : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, assign) CGFloat estimateWidth;
@property (nonatomic, assign) CGFloat estimateHeight;
@property (nonatomic, weak) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *datas;
- (instancetype)initWithPickerView:(UIPickerView *)pickerView;

- (CGFloat)widthThatFit:(CGFloat)width;
- (CGFloat)heightThatFit:(CGFloat)height;
@end


@interface EDJPickerSystemDatasource : EDJPickerDatasource
@end

@interface EDJPickerCustomDatasource : EDJPickerDatasource
@end
