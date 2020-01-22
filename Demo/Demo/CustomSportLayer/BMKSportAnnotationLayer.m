//
//  BMKSportAnnotationLayer.m
//  BMKObjectiveCDemo
//
//  Created by 刘杨 on 2019/11/13.
//  Copyright © 2019 Baidu. All rights reserved.
//

#import "BMKSportAnnotationLayer.h"

@implementation BMKSportAnnotationLayer

- (instancetype)initWithLayer:(id)layer{
    self = [super initWithLayer:layer];
    BMKSportAnnotationLayer *sportLayer = layer;
    self.point = sportLayer.point;
    [self setNeedsDisplay];
    return self;
}

- (void)display{
    BMKSportAnnotationLayer *layer = [self presentationLayer];
    CGPoint point = layer.point;
    if (CGPointEqualToPoint(point, CGPointZero)) {
        return; //免得闪动(因为到了赤道了吧。。)
    }
    CLLocationCoordinate2D coord = (CLLocationCoordinate2D){point.x, point.y};
    self.position = [self.sportLayerDelegate sportAnnotationLayer:self willDisplayToCoordinate:coord];
}

+ (BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"point"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}
@end
