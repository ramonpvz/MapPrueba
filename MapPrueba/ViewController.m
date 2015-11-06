//
//  ViewController.m
//  MapPrueba
//
//  Created by GLBMXM0002 on 11/5/15.
//  Copyright © 2015 unique. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) MKPolyline *routeLine;
@property (retain, nonatomic) MKPolylineView *routeLineView;

@end

@implementation ViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView addAnnotation:self.locationAnnotation];
    self.mapView.showsUserLocation = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self addCustomAnnotation];
    self.passangerFlagImg = [UIImage imageNamed:@"passanger.png"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager setDelegate:self];
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    MKCoordinateRegion region;
    
    CLLocationCoordinate2D location = self.locationAnnotation.coordinate;
    region.center = location;
    region.span.latitudeDelta = 0.02;
    region.span.longitudeDelta = 0.02;
    
    MKPointAnnotation *currentLocation = [[MKPointAnnotation alloc] init];
    currentLocation.coordinate = location;
    
    [mapView setShowsUserLocation:NO];
    [mapView addAnnotation:currentLocation];
    [mapView setRegion:region animated:YES];
    
    [self printAnnotation];
    [self drawRoute];
    
}

- (void) printAnnotation {
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(-32.965136, -60.654957);
    MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
    newAnnotation.coordinate = location;
    [self.mapView  addAnnotation:newAnnotation];
}

- (void) addCustomAnnotation {
    CustomAnnotation *destinyAnnotation = [[CustomAnnotation alloc] initWithTitle:@"Test 1"];
    [self.mapView addAnnotation:destinyAnnotation];

}

- (void) drawRoute {
    
    CLLocationCoordinate2D coordinateArray[2];
    
    coordinateArray[0] = CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude, self.locationAnnotation.coordinate.longitude);
    
    coordinateArray[1] = CLLocationCoordinate2DMake(-32.965136,-60.654957);
    
    self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
    
    [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
    
    [self.mapView addOverlay:self.routeLine];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(self.locationAnnotation == nil)
    {
        self.locationAnnotation = [[MKPointAnnotation alloc] init];
        self.locationAnnotation.title = NSLocalizedString(@"You are here",@"You are here");
        CLLocationCoordinate2D coordinate = ((CLLocation *)[locations lastObject]).coordinate;
        self.locationAnnotation.coordinate = coordinate;
        NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
        [defs setObject:[NSString stringWithFormat:@"%a",coordinate.latitude] forKey:@"latitude"];
        [defs setObject:[NSString stringWithFormat:@"%a",coordinate.longitude] forKey:@"longitud"];
        [defs synchronize];
        [self.mapView addAnnotation:self.locationAnnotation];
    }
    else
    {
        self.locationAnnotation.coordinate = ((CLLocation *)[locations lastObject]).coordinate;
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    if (overlay == self.routeLine)
    {
        if (nil == self.routeLineView) {
            
            MKPolylineRenderer *lineView = [[MKPolylineRenderer alloc] initWithPolyline:self.routeLine];
            
            lineView.strokeColor = [UIColor greenColor];
            lineView.lineWidth = 1;
            
            return lineView;
            
        }
        
    }
    
    return nil;

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[CustomAnnotation class]]) {
        CustomAnnotation *customAnnotation = (CustomAnnotation *) annotation;
        MKAnnotationView *annotationView = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotation"];
        if (annotationView) {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:customAnnotation reuseIdentifier:@"MyCustomAnnotation"];
            annotationView.canShowCallout = YES;
        }
        
        return annotationView;
    }
    else
    {
        return nil;
    }
}

@end
