//
//  SAN_descriptionViewController.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/29/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_descriptionViewController.h"

@interface SAN_descriptionViewController ()

@end

@implementation SAN_descriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)saveText{
    [self.delegate setDescriptionText:self.description.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)popController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveText)];
    self.navigationItem.rightBarButtonItem = item;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(popController)];
    self.navigationItem.leftBarButtonItem =item2;
}
-(void)viewDidAppear:(BOOL)animated{
    [self.description becomeFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
