//
//  SAN_annotation.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/29/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_annotation.h"

@implementation SAN_annotation

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
    if ((self = [super init])) {
        self.coordinate =coordinate;
        self.title = title;
    }
    return self;
}

@end
