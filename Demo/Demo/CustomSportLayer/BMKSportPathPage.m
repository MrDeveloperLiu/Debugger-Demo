//
//  BMKSportPathPage.m
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/11.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import "BMKSportPathPage.h"
#import "BMKSportAnnotationView.h"

#define DefineImp 1

//复用annotationView的指定唯一标识
static NSString *annotationViewIdentifier = @"com.Baidu.BMKSportPath";

//开发者通过此delegate获取mapView的回调方法
@interface BMKSportPathPage ()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView; //当前界面的mapView

@property (nonatomic, strong) BMKPointAnnotation *sportAnnotation; //当前界面的标注
@property (nonatomic, strong) BMKSportAnnotationView *sportAnnotationView; //标注View
@property (nonatomic, strong) NSMutableArray *sportNodes;
@property (nonatomic, assign) NSUInteger sportNodeNum;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, assign) BOOL isAnimated;

@property (nonatomic, strong) BMKPolyline *trackingPolyline;
@property (nonatomic, strong) BMKPolyline *pathPolyline;

@end

@implementation BMKSportPathPage

#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self createMapView];
    [self fetchSportNodes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    //当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    //当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [_mapView viewWillDisappear];
}

#pragma mark - Config UI
- (void)configUI {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"运动轨迹";
}

- (void)createMapView {
    //将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
    //设置mapView的代理
    _mapView.delegate = self;
    //设置地图比例尺级别
    _mapView.zoomLevel = 19;
    //设置当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(40.056898, 116.307626);
}

#pragma mark - SportPath
- (void)fetchSportNodes {
    _sportNodes = [NSMutableArray array];
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sport_path" ofType:@"json"]];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    for (NSDictionary *dictionary in array) {
        BMKSportNode *sportNode = [[BMKSportNode alloc] init];
        sportNode.coordinate  = CLLocationCoordinate2DMake([dictionary[@"lat"] doubleValue], [dictionary[@"lon"] doubleValue]);
        sportNode.angle = [dictionary[@"angle"] doubleValue];
        sportNode.distance = [dictionary[@"distance"] doubleValue];
        sportNode.speed = [dictionary[@"speed"] doubleValue];
        [_sportNodes addObject:sportNode];
    }
    _sportNodeNum = _sportNodes.count;
}

- (void)start {
    NSMutableArray *texture = [NSMutableArray array];
    CLLocationCoordinate2D paths[_sportNodeNum];
    for (NSUInteger i = 0; i < _sportNodeNum; i ++) {
        BMKSportNode *node = _sportNodes[i];
        paths[i] = node.coordinate;
        [texture addObject:@(0)];
    }
    /**
     根据多个经纬点生成多边形
     
     @param coords 经纬度坐标点数组
     @param count 点的个数
     @return 新生成的BMKPolygon实例
     */
    _pathPolyline = [BMKPolyline polylineWithCoordinates:paths count:_sportNodeNum textureIndex:texture];
    /**
     向地图View添加Overlay，需要实现BMKMapViewDelegate的-mapView:viewForOverlay:
     方法来生成标注对应的View
     
     @param overlay 要添加的overlay
     */
    [_mapView addOverlay:_pathPolyline];
    //初始化标注类BMKPointAnnotation的实例
    _sportAnnotation = [[BMKPointAnnotation alloc] init];
    //设置标注的经纬度坐标
    _sportAnnotation.coordinate = paths[0];
    //设置标注的标题
    _sportAnnotation.title = @"运动轨迹";
    //将标注添加到当前地图View中
    [_mapView addAnnotation:_sportAnnotation];
    _currentIndex = 0;
    _isAnimated = YES;
}


- (void)running {
    BMKSportNode *sportNode = _sportNodes[_currentIndex % _sportNodeNum];

    NSUInteger nextIndex = _currentIndex + 1;
    BMKSportNode *nextNode = _sportNodes[nextIndex % _sportNodeNum];
    
    //更新朝向
    [_sportAnnotationView updateHeadingWithAngle:sportNode.angle];
    //运动动画
    __weak __typeof(self) ws = self;
    [_sportAnnotationView trackingToSportNode:sportNode toAnotherNode:nextNode completion:^{
        [ws trackingPolylineWithCoordinate:nextNode.coordinate];

        ws.currentIndex ++;
        [ws running];
    }];

}

- (void)trackingPolylineWithCoordinate:(CLLocationCoordinate2D)coordinate{
    BMKMapPoint *points = self.pathPolyline.points;
    NSUInteger pointCount = self.pathPolyline.pointCount;
    
    BMKMapPoint trackPoint = BMKMapPointForCoordinate(coordinate);
    
    BMKMapPoint trackPoints[pointCount];
    NSUInteger trackPointCount = 0;
    NSMutableArray *texture = [NSMutableArray array];
    
    for (int i = 0; i < pointCount; i++) {
        BMKMapPoint point = points[i];
        
        trackPoints[i] = point;
        [texture addObject:@(1)];
        trackPointCount ++;
        
        if (BMKMapPointEqualToPoint(point, trackPoint)) { //为止
            break;
        }
    }
    
    if (!_trackingPolyline) {
        _trackingPolyline = [BMKPolyline polylineWithPoints:trackPoints count:trackPointCount textureIndex:texture];
        [self.mapView addOverlay:_trackingPolyline];
    }else{
        [_trackingPolyline setPolylineWithPoints:trackPoints count:trackPointCount textureIndex:texture];
    }
}

#pragma mark - BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    [self start];
}

/**
 根据overlay生成对应的BMKOverlayView
 
 @param mapView 地图View
 @param overlay 指定的overlay
 @return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polygonView = [[BMKPolylineView alloc] initWithPolyline:overlay];
        polygonView.colors = @[
            [UIColor colorWithRed:0 green:0.5 blue:0 alpha:0.6],
            [UIColor colorWithRed:0.6 green:0.5 blue:0 alpha:0.6]
        ];
        polygonView.lineWidth = 6.0;
        return polygonView;
    }
    return nil;
}

/**
 根据anntation生成对应的annotationView
 
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if (!_sportAnnotationView) {
        _sportAnnotationView = [[BMKSportAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
        _sportAnnotationView.frame = CGRectMake(0, 0, 22, 22);
        _sportAnnotationView.draggable = NO;
        BMKSportNode *sportNode = [_sportNodes firstObject];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        imageView.transform = CGAffineTransformMakeRotation(sportNode.angle);
        imageView.image = [UIImage imageNamed:@"sportArrow.png"];
        imageView.tag = 10000000;
        _sportAnnotationView.mapView = mapView;
        [_sportAnnotationView addSubview:imageView];
    }
    return _sportAnnotationView;
}
/**
 当mapView新添加annotationViews时，调用此方法

 @param mapView 地图View
 @param views 新添加的annotationView
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    [self running];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _isAnimated = NO;
}

#pragma mark - Lazy loading
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kViewTopHeight - KiPhoneXSafeAreaDValue)];
    }
    return _mapView;
}

@end
