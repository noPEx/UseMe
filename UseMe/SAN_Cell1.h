//
//  SAN_Cell1.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/30/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAN_Cell1 : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *category;
@property (strong, nonatomic) IBOutlet UILabel *pay;
@property (strong, nonatomic) IBOutlet UILabel *serviceName;
@property (strong, nonatomic) IBOutlet UILabel *personName;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *availableTime;
@property (strong, nonatomic) IBOutlet UILabel *description;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIImageView *categoryIcon;

@end
