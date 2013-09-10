//
//  FavoritesViewController.m
//  UseMe
//
//  Created by Soumya Mandi on 9/10/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
             
        UIImage *tabImg = [UIImage imageNamed:@"tab_favorite_normal.png"];
        self.tabBarItem.image = tabImg;
        self.tabBarItem.title = @"Favorites";
        
        UIImage *selectedImg = [UIImage imageNamed:@"tab_favorite_selected.png"];
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
