//
//  EDJListViewCell.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJTableListViewCell.h"
#import "EDJKeyValueObserver.h"

@interface EDJTableListViewCell ()
@property (nonatomic, strong) EDJKeyValueObserver *observer;
@end

@implementation EDJTableListViewCell

- (void)dealloc{
    [self _releaseKvo];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setModel:(EDJListObject *)model{
    if (_model != model) {
        [self _releaseKvo];
        _model = model;
        [self _initKvo];
        [self resetContent:model.content];
        [self resetModel:model];
    }
}

- (void)resetModel:(EDJListObject *)model{
    if (model.selected) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)resetContent:(id)content{    
    if ([content isKindOfClass:[NSString class]]) {
        self.textLabel.text = content;
    }
    if ([content isKindOfClass:[NSAttributedString class]]) {
        self.textLabel.attributedText = content;
    }
    if ([content isKindOfClass:[NSDictionary class]]) {
        NSString *title = content[@"title"];
        if ([title isKindOfClass:[NSString class]]) {
            self.textLabel.text = title;
        }        
    }
}

- (void)_releaseKvo{
    [_observer finished];
    _observer = nil;
    _model = nil;
}

- (void)_initKvo{
    NSArray *keypaths = [self keypaths];
    if (keypaths.count <= 0) {
        return;
    }
    __weak __typeof(self) ws = self;
    _observer = [[EDJKeyValueObserver alloc] initWithTarget:_model keypath:keypaths changed:^(NSString *keyPath, id oldValue, id newValue) {
        [ws onModelChanged:keyPath old:oldValue new:newValue];
    }];
    [_observer beigin];
}


- (NSArray *)keypaths{
    return @[@"selected"];
}

- (void)onModelChanged:(NSString *)keyPath old:(id)oldValue new:(id)newValue{
    if ([keyPath isEqualToString:@"selected"]) {
        [self resetModel:_model];
    }
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [UIImageView new];
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

- (UILabel *)txtLabel{
    if (!_txtLabel) {
        _txtLabel = [UILabel new];
        _txtLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_txtLabel];
    }
    return _txtLabel;
}

- (UILabel *)detailTxtLabel{
    if (!_detailTxtLabel) {
        _detailTxtLabel = [UILabel new];
        _detailTxtLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_detailTxtLabel];
    }
    return _detailTxtLabel;
}

- (UIButton *)jumpBtn{
    if (!_jumpBtn) {
        _jumpBtn = [UIButton new];
        [self.contentView addSubview:_jumpBtn];
    }
    return _jumpBtn;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [UIImageView new];
        [self.contentView addSubview:_arrowView];
    }
    return _arrowView;
}
@end
