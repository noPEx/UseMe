//
//  SAN_selectServiceViewController.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/27/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class SAN_selectServiceViewController;
@protocol SelectViewControllerProtocol <NSObject>

-(void)serviceIconSelected:(NSUInteger)index;

@end


@interface SAN_selectServiceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *art_design;
@property (strong, nonatomic) IBOutlet UIButton *finance;
@property (strong, nonatomic) IBOutlet UIButton *entertainment;
@property (strong, nonatomic) IBOutlet UIButton *sales_marketing;
@property (strong, nonatomic) IBOutlet UIButton *service;
@property (strong, nonatomic) IBOutlet UIButton *manufacturing;
@property (strong, nonatomic) IBOutlet UIButton *health;
@property (strong, nonatomic) IBOutlet UIButton *housekeeping;
@property (strong, nonatomic) IBOutlet UIButton *science_tect;
@property (strong, nonatomic) IBOutlet UIButton *other;

@property (strong, nonatomic) IBOutlet UIButton *art_design_text;
@property (strong, nonatomic) IBOutlet UIButton *finance_text;
@property (strong, nonatomic) IBOutlet UIButton *entertainment_text;
@property (strong, nonatomic) IBOutlet UIButton *sales_marketing_text;
@property (strong, nonatomic) IBOutlet UIButton *service_text;
@property (strong, nonatomic) IBOutlet UIButton *manufacturing_text;
@property (strong, nonatomic) IBOutlet UIButton *health_text;
@property (strong, nonatomic) IBOutlet UIButton *housekeeping_text;
@property (strong, nonatomic) IBOutlet UIButton *science_tect_text;
@property (strong, nonatomic) IBOutlet UIButton *other_text;

@property id<SelectViewControllerProtocol> delegate;
- (IBAction)onSelect:(UIButton *)sender;

@end
