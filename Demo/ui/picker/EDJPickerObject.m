//
//  EDJPickerObject.m
//  edaijia
//
//  Created by 刘杨 on 2019/11/11.
//

#import "EDJPickerObject.h"

@implementation EDJPickerObjectPair
- (instancetype)initWithTitle:(NSString *)title value:(id)value{
    self = [super init];
    _title = title;
    _value = value;
    return self;
}
+ (instancetype)pairWithTitle:(NSString *)title value:(id)value{
    return [[self alloc] initWithTitle:title value:value];
}
- (BOOL)isEqual:(id)object{
    if (![object isKindOfClass:[EDJPickerObjectPair class]]) {
        return NO;
    }
    EDJPickerObjectPair *rhs = object;
    if ([self.title isEqual:rhs.title] && [self.value isEqual:rhs.value]) {
        return YES;
    }
    return [super isEqual:object];
}
@end

@implementation EDJPickerObject

- (void)setContent:(id)content{
    _content = content;
        
    if ([content isKindOfClass:[NSString class]]) {
        self.title = content;
    }else if ([content isKindOfClass:[EDJPickerObjectPair class]]){
        self.title = [(EDJPickerObjectPair *)content title];
    }
}
@end
