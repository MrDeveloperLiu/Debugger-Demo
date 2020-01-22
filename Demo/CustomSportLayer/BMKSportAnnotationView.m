//
//  BMKSportAnnotationView.m
//  BMKObjectiveCDemo
//
//  Created by 刘杨 on 2019/11/13.
//  Copyright © 2019 Baidu. All rights reserved.
//

#import "BMKSportAnnotationView.h"


@interface BMKSportAnnotationView ()<CAAnimationDelegate, BMKSportAnnotationLayerDelegate>
@property (nonatomic, strong) BMKSportNode *lastNode;
@property (nonatomic, strong) BMKSportNode *fromNode;
@property (nonatomic, strong) BMKSportNode *toNode;
@property (nonatomic, assign) BOOL translating;
@property (nonatomic, copy) dispatch_block_t completionBlock;
@end

@implementation BMKSportAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    BMKSportAnnotationLayer *layer = (BMKSportAnnotationLayer *)self.layer;
    layer.sportLayerDelegate = self;
    return self;
}

- (CGPoint)sportAnnotationLayer:(BMKSportAnnotationLayer *)layer willDisplayToCoordinate:(CLLocationCoordinate2D)coordinate{
    CGPoint center = [self.mapView convertCoordinate:coordinate toPointToView:self.mapView];
    return center;
}

+ (Class)layerClass{
    return [BMKSportAnnotationLayer class];
}

- (void)updateHeadingWithAngle:(CGFloat)angle{
    UIView *imageView = [self viewWithTag:10000000];
    imageView.transform = CGAffineTransformMakeRotation(angle);
}

- (void)trackingToSportNode:(BMKSportNode *)node toAnotherNode:(BMKSportNode *)toNode completion:(dispatch_block_t)completion{
    if (_translating) {
        return;
    }
    _translating = YES;
    
    _fromNode = node;
    _toNode = toNode;
    _completionBlock = completion;
    
    CGPoint start = CGPointMake(node.coordinate.latitude, node.coordinate.longitude);
    NSValue *startPointValue = [NSValue valueWithCGPoint:start];
    CGPoint end = CGPointMake(toNode.coordinate.latitude, toNode.coordinate.longitude);
    NSValue *endPointValue = [NSValue valueWithCGPoint:end];
    NSTimeInterval duration = node.distance / node.speed;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:startPointValue];
    [values addObject:endPointValue];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"point"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.delegate = self;
    animation.values = values;
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animation forKey:@"translate"];
}
/*
- (void)animationDidStart:(CAAnimation *)anim{
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]) {
        CAKeyframeAnimation *keyAnimatation = (CAKeyframeAnimation *)anim;
        if ([keyAnimatation.keyPath isEqualToString:@"point"]) {
            
        }
    }
}
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isKindOfClass:[CAKeyframeAnimation class]]) {
        CAKeyframeAnimation *keyAnimatation = (CAKeyframeAnimation *)anim;
        if ([keyAnimatation.keyPath isEqualToString:@"point"]) {
            self.annotation.coordinate = _toNode.coordinate;
            _lastNode = _toNode; //cache
            
            _translating = NO;
            _toNode = nil;
            _fromNode = nil;
            
            if (_completionBlock) {
                _completionBlock();
            }
        }
    }
}
@end

