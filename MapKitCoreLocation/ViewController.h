//
//  ViewController.h
//  MapKitCoreLocation
//
//  Created by Vitor Kawai Sala on 26/02/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>


@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property CLLocationManager *locationManager;

@property CLLocationCoordinate2D coordinate;

- (IBAction)btnLock:(id)sender;

- (IBAction)btnCreatePoint:(id)sender;

- (IBAction)btnClear:(id)sender;

-(void)test:(UITapGestureRecognizer *)sender;
@end

