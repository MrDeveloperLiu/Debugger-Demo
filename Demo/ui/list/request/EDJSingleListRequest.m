//
//  EDJSingleListRequest.m
//  edaijia
//
//  Created by 刘杨 on 2019/12/14.
//

#import "EDJSingleListRequest.h"

@implementation EDJSingleListRequest

- (void)dealloc{
//    _requestBlock = nil;
    _transformBlock = nil;
    _dataBlock = nil;
    _errorBlock = nil;
}

- (instancetype)init{
    self = [super init];
    _limit = 5;
    return self;
}

- (void)beginRequest{
//    @weakify(self);
//    self.request = self.requestBlock(self);
//    [self.request subscribeSuccess:^(id response) {
//        [__weak_self__ onResponse:response error:nil];
//    } failed:^(EDJRequestError *error) {
//        [__weak_self__ onResponse:nil error:error];
//    }];
//    [self.request start];
}

- (void)reset{
    _current = 0;
    _done = NO;
}

- (void)onResponse:(id)resp error:(NSError *)error{
//    self.request = nil;
    if (error) {
        if (self.errorBlock) {
            self.errorBlock(error, self);
        }        
        return;
    }
    NSMutableArray *list = self.transformBlock(resp, self);
    [self onListBuild:list];
}

- (void)onListBuild:(NSMutableArray *)list{
    _current ++;
    if (list.count < _limit) {
        _done = YES;
    }
    self.dataBlock(list, self);
}

- (NSInteger)fromIndex{
    NSInteger idx = (self.current * self.limit);
    return idx;
}
@end
