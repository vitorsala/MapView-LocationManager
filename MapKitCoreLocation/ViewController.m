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

    [_locationManager startUpdatingLocation];

    _mapView.showsUserLocation = true;
    _mapView.userTrackingMode = true;

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)];
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

-(void)test{
    [_mapView addAnnotation:[[Annotation alloc] initWithCoordinate:_coordinate abdTitle:@"title"]];
}

@end
