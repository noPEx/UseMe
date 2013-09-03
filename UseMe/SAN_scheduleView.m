//
//  SAN_scheduleView.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/28/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_scheduleView.h"
@interface SAN_scheduleView()

@end
@implementation SAN_scheduleView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0,0,320,290)];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"schedule" owner:self options:nil] objectAtIndex:0];
        [self addSubview:view];
        NSLog(@"%f",view.frame.size.height);
        self.arr = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:TRUE],[NSNumber numberWithBool:TRUE],[NSNumber numberWithBool:TRUE],[NSNumber numberWithBool:TRUE],[NSNumber numberWithBool:TRUE],[NSNumber numberWithBool:false],[NSNumber numberWithBool:false], nil];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 320, 192)];
        //self.pickerView.showsSelectionIndicator =YES;
        [self addSubview:self.pickerView];
        //setting set button
        self.set = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.set.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.set.layer setBorderWidth:1.0f];
        [self.set setTitle:@"set" forState:UIControlStateNormal];
        [self.set setFrame:CGRectMake(0,self.pickerView.frame.origin.y+ self.pickerView.frame.size.height +5, 320, 30)];
        [self addSubview:self.set];
        //setting cancel button
        self.cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.cancel setTitle:@"cancel" forState:UIControlStateNormal];
        [self.cancel setFrame:CGRectMake(0, self.set.frame.origin.y + self.set.frame.size.height, 320, 30)];
        [self addSubview:self.cancel];
    }
    return self;
}



- (IBAction)daySelected:(UIButton *)sender {
    NSUInteger i;
    if(sender == self.mon)
        i=0;
    else if (sender == self.tue)
        i=1;
    else if (sender == self.wed)
        i=2;
    else if (sender == self.thu)
        i=3;
    else if (sender == self.fri)
        i=4;
    else if (sender == self.sat)
        i=5;
    else
        i=6;
        
    if([self.arr[i] boolValue]){
        self.arr[i] = [NSNumber numberWithBool:false];
        sender.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.arr[i] = [NSNumber numberWithBool:TRUE];
        sender.backgroundColor = [UIColor redColor];
    }
        
}
@end







