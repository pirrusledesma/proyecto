//
//  MapViewController.m
//  proyecto
//
//  Created by Ileana Padilla on 4/4/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface MapViewController (){
    NSString *latitude;
    NSString *longitude;
    MKPointAnnotation *annot;
    CLLocationCoordinate2D location1;
    MKPinAnnotationView *anno;
}

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView.delegate=self;
    
    location1.latitude=(double) 20.696761;
    location1.longitude=(double) -103.417855;
    
    [self mapa];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapa{
    
    MKPointAnnotation *point1 =[[MKPointAnnotation alloc] init];
    point1.coordinate = CLLocationCoordinate2DMake(location1.latitude, location1.longitude);
    //latitude=[[NSNumber numberWithDouble:annot.coordinate.latitude]stringValue];
    //latitude=[[NSNumber numberWithDouble:annot.coordinate.longitude]stringValue];
    point1.title = @"Universidad Autónoma de Guadalajara";
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location1, 1500, 1500);
    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView addAnnotation:point1];
    
}

#pragma mark Delegate Methods


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    NSString* addr = [NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%1.6f,%1.6f&saddr=Posizione attuale", location1.latitude,location1.longitude];
    NSURL* url = [[NSURL alloc] initWithString:[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
    
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation

{
    anno = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    anno.canShowCallout = YES;
    anno.pinColor = MKPinAnnotationColorRed;
    
    anno.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return anno;
}


@end
