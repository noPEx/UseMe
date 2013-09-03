//
//  SAN_addServiceViewController.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/27/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAN_selectServiceViewController.h"
#import "SAN_paymentView.h"
#import "SAN_scheduleView.h"
#import "SAN_addMapViewController.h"
#import "SAN_descriptionViewController.h"
#import "SAN_sendNewServiceToServer.h"
#import "SAN_requestToServer.h"
@interface SAN_addServiceViewController : UIViewController <SelectViewControllerProtocol,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,SAN_addMapViewControllerProtocol,UITextViewDelegate,SAN_descriptionViewController,UIImagePickerControllerDelegate,SAN_requestToServerProtocol>
@property (strong, nonatomic) IBOutlet UIButton *serviceIconButton;
@property (strong, nonatomic) IBOutlet UITextField *payment;
- (IBAction)selectService:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextField *schedule;
@property (strong, nonatomic) IBOutlet UITextField *serviceName;
@property (strong, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) IBOutlet UIButton *mi_1;
@property (strong, nonatomic) IBOutlet UIButton *mi_2;
@property (strong, nonatomic) IBOutlet UIButton *mi_3;
@property (strong, nonatomic) IBOutlet UIButton *mi_4;
- (IBAction)milesSelected:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIView *portfolioView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIButton *portfolioButton;
- (IBAction)addPortfolioImage:(UIButton *)sender;
@property NSString *sessionId;
@end
