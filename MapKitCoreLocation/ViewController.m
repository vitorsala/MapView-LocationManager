//
//  ViewController.m
//  MapKitCoreLocation
//
//  Created by Vitor Kawai Sala on 26/02/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _locationManager = [[CLLocationManager alloc] init];

    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

    [_locationManager setDelegate:self];
    [_mapView setDelegate:self];

    [_locationManager startUpdatingLocation];

    _mapView.showsUserLocation = true;
    _mapView.userTrackingMode = true;

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test:)];
    [_mapView addGestureRecognizer:gesture];

    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _coordinate = [[locations lastObject] coordinate];
}

- (IBAction)btnLock:(id)sender {
    _mapView.userTrackingMode = true;
}

- (IBAction)btnCreatePoint:(id)sender{
    [_mapView addAnnotation:[[Annotation alloc] initWithCoordinate:_coordinate abdTitle:@"title"]];
}

- (IBAction)btnClear:(id)sender {
    [_mapView removeAnnotations:[_mapView annotations]];
    [_mapView removeOverlays:[_mapView overlays]];
}

-(void)test:(UITapGestureRecognizer *)sender{
    [_mapView removeAnnotations:[_mapView annotations]];

    CGPoint point = [sender locationInView:self.view];
    CLLocationCoordinate2D coord = [_mapView convertPoint:point toCoordinateFromView:self.view];
    [_mapView addAnnotation:[[Annotation alloc] initWithCoordinate:coord abdTitle:@"title"]];

    NSArray *arr = [_mapView annotations];

    [self calculatingRouteWithSource:[arr[0] coordinate] andDestination:[arr[1] coordinate]];
}

-(void)calculatingRouteWithSource:(CLLocationCoordinate2D)s andDestination:(CLLocationCoordinate2D)d {

    NSLog(@"%f, %f => %f, %f", s.latitude, s.longitude, d.latitude, d.longitude);

    [_mapView removeOverlays:[_mapView overlays]];

    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:s addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];

    MKMapItem *srcMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    [srcMapItem setName:@""];

    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:d addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];

    MKMapItem *distMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    [distMapItem setName:@""];

    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcMapItem];
    [request setDestination:distMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];

    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];

    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {

//        NSLog(@"response = %@",response);
        NSArray *arrRoutes = [response routes];
        [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

            MKRoute *rout = obj;

            MKPolyline *line = [rout polyline];
            [_mapView addOverlay:line];
//            NSLog(@"Rout Name : %@",rout.name);
//            NSLog(@"Total Distance (in Meters) :%f",rout.distance);

            NSArray *steps = [rout steps];

//            NSLog(@"Total Steps : %lu",[steps count]);

            [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                NSLog(@"Rout Instruction : %@",[obj instructions]);
//                NSLog(@"Rout Distance : %f",[obj distance]);
            }];
        }];
    }];
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        render.lineWidth = 3.0;
        render.strokeColor = [UIColor blueColor];
        return render;
    }
    return nil;
}


@end
