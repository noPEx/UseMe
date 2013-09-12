//
//  CreateServiceViewController.m
//  UseMe
//
//  Created by Soumya Mandi on 9/10/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "CreateServiceViewController.h"

@interface CreateServiceViewController ()

@end

@implementation CreateServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                //self.tabBarItem  = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
        UIImage *tabImg = [UIImage imageNamed:@"tab_create_service_normal.png"];
        self.tabBarItem.image = tabImg;
        //self.tabBarItem.title = @"Create";
        
        UIImage *selectedImg = [UIImage imageNamed:@"tab_create_service_selected.png"];
        [self.tabBarItem setSelectedImage:selectedImg];
        [self.tabBarItem setFinishedSelectedImage:selectedImg withFinishedUnselectedImage:tabImg];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
