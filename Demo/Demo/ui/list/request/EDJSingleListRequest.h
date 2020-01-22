//
//  EDJSingleListRequest.h
//  edaijia
//
//  Created by 刘杨 on 2019/12/14.
//

#import <Foundation/Foundation.h>


@class EDJSingleListRequest;

//typedef EDJApiRequestOperation *(^EDJSingleListRequestBlock)(EDJSingleListRequest *req);
typedef NSMutableArray *(^EDJSingleListRequestTransform)(id resp, EDJSingleListRequest *req);
typedef void (^EDJSingleListRequestDataBlock)(NSMutableArray *datas, EDJSingleListRequest *req);
typedef void (^EDJSingleListRequestErrorBlock)(NSError *error, EDJSingleListRequest *req);

@interface EDJSingleListRequest : NSObject

@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign, readonly) NSInteger current;
@property (nonatomic, assign, readonly) BOOL done;

//@property (nonatomic, strong) EDJApiRequestOperation *request;

//@property (nonatomic, copy) EDJSingleListRequestBlock requestBlock;
@property (nonatomic, copy) EDJSingleListRequestErrorBlock errorBlock;
@property (nonatomic, copy) EDJSingleListRequestTransform transformBlock;
@property (nonatomic, copy) EDJSingleListRequestDataBlock dataBlock;

- (void)reset;
- (void)beginRequest;
- (NSInteger)fromIndex;
- (void)onListBuild:(NSMutableArray *)list;
@end


