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

//    [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager requestAlwaysAuthorization];

    _locationManager = [[CLLocationManager alloc] init];

    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

    [_locationManager setDelegate:self];

    [_locationManager startUpdatingLocation];

    _mapView.showsUserLocation = true;
    _mapView.userTrackingMode = true;

    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    [_mapView setRegion:MKCoordinateRegionMakeWithDistance([[locations lastObject] coordinate], 200, 200) animated:true];
}
@end
