//
//  EDJCollectionRecycleCell.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/14.
//

#import "EDJCollectionRecycleCell.h"
#import "EDJKeyValueObserver.h"

@interface EDJCollectionRecycleCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) EDJKeyValueObserver *modelObserver;
@property (nonatomic, strong) EDJKeyValueObserver *contentObserver;
@end

@implementation EDJCollectionRecycleCell

- (void)dealloc{
    [self _releaseKvo];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)setModel:(EDJRecycleObject *)model{
    if (_model != model) {
        [self _releaseKvo];
        _model = model;
        [self _initKvo];
        
        [self resetContent:model.content];
        [self resetModel:model];
    }
}

- (void)resetModel:(EDJRecycleObject *)model{
    if (model.selected) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)resetContent:(id)content{
    if ([content isKindOfClass:[NSString class]]) {
        self.textLabel.text = content;
    }else if ([content isKindOfClass:[NSAttributedString class]]){
        self.textLabel.attributedText = content;
    }
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _textLabel.numberOfLines = 0;
        [self.contentView addSubview:_textLabel];
    }
    return _textLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}


- (void)_releaseKvo{
    [_modelObserver finished];
    _modelObserver = nil;
    
    [_contentObserver finished];
    _contentObserver = nil;
    
    _model = nil;
}

- (void)_initKvo{
    __weak __typeof(self) ws = self;

    NSArray *keypaths = [self modelKeypaths];
    if (keypaths.count > 0) {
        _modelObserver = [[EDJKeyValueObserver alloc] initWithTarget:_model keypath:keypaths changed:^(NSString *keyPath, id oldValue, id newValue) {
            [ws onModelChanged:keyPath old:oldValue new:newValue];
        }];
        [_modelObserver beigin];
    }

    NSArray *contentKeypaths = [self contentKeypaths];
    if (contentKeypaths.count > 0) {
        _contentObserver = [[EDJKeyValueObserver alloc] initWithTarget:_model.content keypath:contentKeypaths changed:^(NSString *keyPath, id oldValue, id newValue) {
            [ws onContentChanged:keyPath old:oldValue new:newValue];
        }];
        [_contentObserver beigin];
    }
}


- (NSArray *)modelKeypaths{
    return @[@"selected"];
}

- (void)onModelChanged:(NSString *)keyPath old:(id)oldValue new:(id)newValue{
    if ([keyPath isEqualToString:@"selected"]) {
        [self resetModel:_model];
    }
}

- (NSArray *)contentKeypaths{
    return nil;
}

- (void)onContentChanged:(NSString *)keyPath old:(id)oldValue new:(id)newValue{
    
}
@end
