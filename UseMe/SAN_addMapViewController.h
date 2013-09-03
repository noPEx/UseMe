//
//  SAN_addMapViewController.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/28/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SAN_annotation.h"
@class SAN_addMapViewController;
@protocol SAN_addMapViewControllerProtocol <NSObject>
-(void)locationAddress:(CLPlacemark *)pm;

@end

@interface SAN_addMapViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property id<SAN_addMapViewControllerProtocol> delegate;
@end
