//
//  CustomAnnotation.h
//  MapPrueba
//
//  Created by GLBMXM0002 on 11/5/15.
//  Copyright © 2015 unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;

-(id) initWithTitle:(NSString *)newTitle;
- (MKAnnotationView *) annotationView;

@end
