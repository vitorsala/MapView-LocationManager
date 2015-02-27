//
//  Annotation.h
//  MapKitCoreLocation
//
//  Created by Vitor Kawai Sala on 27/02/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Annotation : NSObject <MKAnnotation>
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString* title;
-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate abdTitle:(NSString*) title;

@end
