//
//  SAN_descriptionViewController.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/29/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAN_descriptionViewController;
@protocol SAN_descriptionViewController <NSObject>
-(void)setDescriptionText:(NSString *)text;

@end
@interface SAN_descriptionViewController : UIViewController <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *description;
@property id<SAN_descriptionViewController> delegate;
@end
