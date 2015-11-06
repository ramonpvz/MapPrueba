//
//  CustomAnnotation.m
//  MapPrueba
//
//  Created by GLBMXM0002 on 11/5/15.
//  Copyright © 2015 unique. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

-(id) initWithTitle:(NSString *)newTitle {
    
    self = [super init];
    
    if (self)
    {
        _title = newTitle;
    }
    
    return self;
    
}

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D testlocation = CLLocationCoordinate2DMake(-32.965136, -60.654957);
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = testlocation.latitude;
    theCoordinate.longitude = testlocation.longitude;
    return theCoordinate;
}

- (MKAnnotationView *) annotationView
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

@end
