//
//  SAN_scheduleView.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/28/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface SAN_scheduleView : UIView
@property UIPickerView *pickerView;
@property UIButton *set;
@property UIButton *cancel;
@property (strong, nonatomic) IBOutlet UIButton *mon;
@property (strong, nonatomic) IBOutlet UIButton *tue;
@property (strong, nonatomic) IBOutlet UIButton *wed;
@property (strong, nonatomic) IBOutlet UIButton *thu;
@property (strong, nonatomic) IBOutlet UIButton *fri;
@property (strong, nonatomic) IBOutlet UIButton *sat;
@property (strong, nonatomic) IBOutlet UIButton *sun;
- (IBAction)daySelected:(UIButton *)sender;

@property NSMutableArray *arr;
@end
