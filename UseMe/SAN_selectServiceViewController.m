//
//  SAN_selectServiceViewController.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/27/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_selectServiceViewController.h"

@interface SAN_selectServiceViewController ()

@end

@implementation SAN_selectServiceViewController

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
    //set scrollview
    UIScrollView *sview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.view.backgroundColor = [UIColor grayColor];
    sview.backgroundColor = self.view.backgroundColor;
    UIView *view = self.view;
    self.view = sview;
    [sview addSubview:view];
    ((UIScrollView *)self.view).contentSize =view.frame.size;
    
    //adding corner radius 
    self.art_design.layer.cornerRadius = 35.0f;
    self.art_design.clipsToBounds = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSelect:(UIButton *)sender {
    NSLog(@"clicked");
    NSUInteger i;
    if(sender == self.art_design || sender == self.art_design_text)
        i=0;
    else if(sender == self.finance || sender == self.finance_text)
        i=1;
    else if(sender == self.entertainment || sender == self.entertainment_text)
        i=2;
    else if(sender == self.sales_marketing || sender == self.sales_marketing_text)
        i=3;
    else if(sender == self.service || sender == self.service_text)
        i=4;
    else if(sender == self.manufacturing || sender == self.manufacturing_text)
        i=5;
    else if(sender == self.health || sender == self.health_text)
        i=6;
    else if(sender == self.housekeeping || sender == self.housekeeping_text)
        i=7;
    else if(sender == self.science_tect || sender == self.science_tect_text)
        i=8;
    else
        i=9;
    [self.delegate serviceIconSelected:i];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
