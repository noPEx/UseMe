//
//  SAN_paymentView.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/27/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_paymentView.h"

@implementation SAN_paymentView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0,0,320,250)];
    if (self) {
        
        
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 192)];
        //self.pickerView.showsSelectionIndicator =YES;
        [self addSubview:self.pickerView];
        //setting set button
        self.set = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.set.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.set.layer setBorderWidth:1.0f];
        [self.set setTitle:@"set" forState:UIControlStateNormal];
        [self.set setFrame:CGRectMake(0, self.pickerView.frame.size.height +5, 320, 30)];
        [self addSubview:self.set];
        //setting cancel button
        self.cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.cancel setTitle:@"cancel" forState:UIControlStateNormal];
        [self.cancel setFrame:CGRectMake(0, self.set.frame.origin.y + self.set.frame.size.height, 320, 30)];
        [self addSubview:self.cancel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
