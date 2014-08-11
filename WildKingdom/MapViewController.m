//
//  MapViewController.m
//  WildKingdom
//
//  Created by Alejandro Tami on 08/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "JSONManager.h"

@interface MapViewController ()<JSONManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [JSONManager getInstance].delegate = self;
    [[JSONManager getInstance] makeGeoRequestForPhoto:self.photoID];
}


- (void) responseWithJSON:(NSDictionary *) json
{
    
}

- (void) responseWithGeoLocation:(CLLocationCoordinate2D) coordinates
{
    
    MKPointAnnotation *point = [MKPointAnnotation new];
   
    point.coordinate = coordinates;
    
    [self.mapView addAnnotation:point];
    
    MKCoordinateRegion region;
    region.center.latitude = point.coordinate.latitude;
    region.center.longitude = point.coordinate.longitude;
    region.span.latitudeDelta =  1;
    region.span.longitudeDelta =  1;
    
    [self.mapView setRegion:region animated:YES];

    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation != self.mapView.userLocation){
        
        MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
              
        return pin;
    } else {
        return  nil;
    }
}


@end
