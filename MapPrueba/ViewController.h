//
//  ViewController.h
//  MapPrueba
//
//  Created by GLBMXM0002 on 11/5/15.
//  Copyright © 2015 unique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKPointAnnotation *locationAnnotation;
@property (nonatomic, strong) UIImage *passangerFlagImg;

@end
