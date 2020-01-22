//
//  EDJListHeaderFooterView.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJTableListHeaderFooterView.h"

@implementation EDJTableListHeaderFooterView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.backgroundView = [UIView new];
    return self;
}

- (void)setModel:(EDJListHeaderFooterObject *)model{
    if (_model != model) {
        _model = model;
        [self resetContent:model.content];
        [self resetModel:model];
    }
}

- (void)resetModel:(EDJListHeaderFooterObject *)model{
    
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
@end
