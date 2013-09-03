//
//  SAN_addMapViewController.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/28/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_addMapViewController.h"
#define METERS_PER_MILE 1609.344
@interface SAN_addMapViewController ()
@property SAN_annotation *annotation;
@end

@implementation SAN_addMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setPinClicked{
    if(self.annotation == nil){
        self.annotation = [[SAN_annotation alloc] initWithCoordinate:self.mapView.centerCoordinate title:@"pin here"];
        [self.mapView addAnnotation:self.annotation];
    }
    self.annotation.coordinate = self.mapView.centerCoordinate;
    [self.mapView reloadInputViews];
}
-(void)popController{
    if(self.annotation == nil){
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    CLGeocoder *gc = [[CLGeocoder alloc] init];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:self.annotation.coordinate.latitude longitude:self.annotation.coordinate.longitude];
    [gc reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"completion %d",[placemarks count]);
        if([placemarks count] >0){
            CLPlacemark *pm = [placemarks objectAtIndex:0];
            [self.delegate locationAddress:pm];
        }
        else{
            NSLog(@"no placemark received");
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }else {
        annotationView.annotation = annotation;
    }
    //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //setting nav items
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Set Pin" style:UIBarButtonItemStyleBordered target:self action:@selector(setPinClicked)];
    self.navigationItem.rightBarButtonItem = item;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(popController)];
    self.navigationItem.leftBarButtonItem =item2;
    self.mapView.delegate =self;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location.coordinate, .5*METERS_PER_MILE, .5*METERS_PER_MILE);
    [self.mapView setRegion:region animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"called");
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, .5*METERS_PER_MILE, .5*METERS_PER_MILE);
    [mapView setRegion:region animated:YES];
}
@end
