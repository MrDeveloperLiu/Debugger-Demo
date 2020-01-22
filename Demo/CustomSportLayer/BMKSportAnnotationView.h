//
//  BMKSportAnnotationView.h
//  BMKObjectiveCDemo
//
//  Created by 刘杨 on 2019/11/13.
//  Copyright © 2019 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKSportAnnotationLayer.h"


@interface BMKSportAnnotationView : BMKAnnotationView

@property (nonatomic, weak) BMKMapView *mapView;

- (void)updateHeadingWithAngle:(CGFloat)angle;

- (void)trackingToSportNode:(BMKSportNode *)node toAnotherNode:(BMKSportNode *)toNode completion:(dispatch_block_t)completion;

@end
