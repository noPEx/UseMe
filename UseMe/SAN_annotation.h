//
//  SAN_annotation.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/29/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface SAN_annotation : NSObject<MKAnnotation>
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (strong,nonatomic) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
@end
