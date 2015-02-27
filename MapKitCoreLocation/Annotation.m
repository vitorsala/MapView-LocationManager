//
//  Annotation.m
//  MapKitCoreLocation
//
//  Created by Vitor Kawai Sala on 27/02/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation


-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate abdTitle:(NSString*) title{
    self = [super init];
    if(self){
        _coordinate = coordinate;
        _title = title;
    }
    return self;
}

@end
