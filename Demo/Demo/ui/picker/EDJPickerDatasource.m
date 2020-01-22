//
//  EDJPickerDatasource.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/11.
//

#import "EDJPickerDatasource.h"

@implementation EDJPickerDatasource

- (instancetype)initWithPickerView:(UIPickerView *)pickerView{
    self = [super init];
    _estimateHeight = 50;
    _pickerView = pickerView;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    return self;
}

- (EDJPickerObjects *)rowsAtComponent:(NSInteger)component{
    EDJPickerObjects *rows = [_datas objectAtIndex:component];
    return rows;
}

- (EDJPickerObject *)itemAtRow:(NSInteger)row component:(NSInteger)component{
    EDJPickerObjects *rows = [self rowsAtComponent:component];
    EDJPickerObject *item = [rows.objects objectAtIndex:row];
    return item;
}

- (void)setDatas:(NSMutableArray *)datas{
    if (_datas != datas) {
        _datas = datas;
        //计算预估宽度
        _estimateWidth = (CGRectGetWidth(self.pickerView.frame) / datas.count);
        //刷新view
        [self.pickerView reloadAllComponents];
        //预先选中每个的第一个，则会出现选中框
        [self loadSelectedRow:datas];
    }
}

- (void)loadSelectedRow:(NSArray *)datas{
    NSInteger(^selectedBlock)(EDJPickerObjects *rows) = ^NSInteger(EDJPickerObjects *rows){
        for (int row = 0; row < rows.objects.count; row++) {
            EDJPickerObject *object = [rows.objects objectAtIndex:row];
            if (object.selected) {
                return row;
            }
        }
        return 0;
    };
    for (int component = 0; component < datas.count; component ++) {
        EDJPickerObjects *allRows = [datas objectAtIndex:component];
        NSInteger selectedRow = selectedBlock(allRows);
        [self.pickerView selectRow:selectedRow inComponent:component animated:NO];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSInteger components = _datas.count;
    return components;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    EDJPickerObjects *rows = [self rowsAtComponent:component];
    return rows.objects.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    EDJPickerObjects *rows = [self rowsAtComponent:component];
    if (rows.selectObject) {
        rows.selectObject.selected = NO;
        rows.selectObject = nil;
    }    
    EDJPickerObject *object = [self itemAtRow:row component:component];
    object.selected = YES;
    rows.selectObject = object;
}

- (CGFloat)widthThatFit:(CGFloat)width{
    if (width <= 0) {
        return self.estimateWidth;
    }
    return width;
}
- (CGFloat)heightThatFit:(CGFloat)height{
    if (height <= 0) {
        return self.estimateHeight;
    }
    return height;
}
@end

@implementation EDJPickerSystemDatasource


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    EDJPickerObjects *rows = [self rowsAtComponent:component];
    return [self widthThatFit:rows.width];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    EDJPickerObjects *rows = [self rowsAtComponent:component];
    return [self heightThatFit:rows.height];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    EDJPickerObject *object = [self itemAtRow:row component:component];
    return object.title;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    EDJPickerObject *object = [self itemAtRow:row component:component];
    return object.attributeTitle;
}
@end


@implementation EDJPickerCustomDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    EDJPickerObjects *rows = [self.datas objectAtIndex:component];
    EDJPickerObject *model = [rows.objects objectAtIndex:row];
    UIView<EDJPickerObjectProtocol>* v = (UIView<EDJPickerObjectProtocol>*)view;
    if (!v) {
        Class class = model.viewClass;
        if (!class) {
            return nil;
        }
        CGRect frame = CGRectMake(0, 0, [self widthThatFit:rows.width], [self heightThatFit:rows.height]);
        v = (UIView<EDJPickerObjectProtocol>*)[(UIView *)[class alloc] initWithFrame:frame];
    }
    v.model = model;
    return view;
}

@end
