//
//  BMKSportNode.h
//  BMKObjectiveCDemo
//
//  Created by 刘杨 on 2019/11/13.
//  Copyright © 2019 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMKSportNode : NSObject
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) CGFloat speed;
@end
