//
//  SAN_Cell1.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/30/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_Cell1.h"

@implementation SAN_Cell1


- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"SAN_Cell1" owner:self options:nil] objectAtIndex:0];
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
