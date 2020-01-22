//
//  BMKSportAnnotationLayer.h
//  BMKObjectiveCDemo
//
//  Created by 刘杨 on 2019/11/13.
//  Copyright © 2019 Baidu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BMKSportNode.h"

@class BMKSportAnnotationLayer;

@protocol BMKSportAnnotationLayerDelegate <NSObject>
- (CGPoint)sportAnnotationLayer:(BMKSportAnnotationLayer *)layer willDisplayToCoordinate:(CLLocationCoordinate2D)coordinate;
@end

@interface BMKSportAnnotationLayer : CALayer
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, weak) id<BMKSportAnnotationLayerDelegate> sportLayerDelegate;
@end
