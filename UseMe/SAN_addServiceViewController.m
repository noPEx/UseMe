//
//  SAN_addServiceViewController.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/27/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_addServiceViewController.h"
#define METERS_PER_MILE 1609.344

@interface values_struct : NSObject
@property NSInteger row1;
@property NSInteger row2;
@property NSInteger row3;
@property NSInteger row4;
@end

@implementation values_struct
-(id)init{
    self.row1 =0;
    self.row2 =0;
    self.row3 =0;
    self.row4 =0;
    return self;
}
@end

@interface SAN_addServiceViewController ()
@property SAN_paymentView *paymentView;
@property SAN_scheduleView *scheduleView;
@property NSArray *paymentCurrency;
@property values_struct *pvalues;
@property values_struct *svalues;
@property NSMutableArray *portfolioImages;
@property UIScrollView *scrollView;
@property CLPlacemark *placemark;
@property Float32 radius;
@property NSUInteger category;
@end



@implementation SAN_addServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)paymentSet{
    [self.payment resignFirstResponder];
    NSString *perTime = @"HOUR";
    if(self.pvalues.row3 ==1)
        perTime = @"DAY";
    [self.payment setText:[NSString stringWithFormat:@" %d %@ / %@",self.pvalues.row1 +1,self.paymentCurrency[self.pvalues.row2],perTime]];
}
-(void)scheduleSet{
    [self.schedule resignFirstResponder];
    NSString *pace1 = @"AM";
    if(self.svalues.row2 == 1)
        pace1 = @"PM";
    NSString *pace2 = @"AM";
    if(self.svalues.row4 ==1)
        pace2 = @"PM";
    NSMutableString *text;
    text =[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@" %d%@ - %d%@ ",self.svalues.row1 +1,pace1,self.svalues.row3+1,pace2]];
    BOOL b =false;
    NSUInteger lastSet=-1;
    for(NSUInteger i=0;i<7;i++){
        if([self.scheduleView.arr[i] boolValue]){
            if(b){
                if(i != 6)
                    continue;
                else{
                    [text appendString:@"-SAT"];
                    continue;
                }
            }
            else{
                b=!b;
                lastSet =i;
                [text appendString:[self getDateName:i]];
                
            }
        }
        else{
            if(b){
                b=!b;
                if(i == (lastSet +1)){
                    [text appendString:@","];
                    continue;
                }
                else
                    [text appendString:[NSString stringWithFormat:@"-%@,",[self getDateName:(i-1)]]];
            }
        }
    }
    self.schedule.text = text;
    
    
}
-(NSString *)getDateName:(NSUInteger)i{
    switch (i) {
        
        case 0:
            return @"Mon";
        case 1:
            return @"Tue";
        case 2:
            return @"Wed";
        case 3:
            return @"Thu";
        case 4:
            return @"Fri";
        case 5:
            return @"Sat";
        default:
            return @"Sun";
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if(textView == self.description){
        SAN_descriptionViewController *vc = [[SAN_descriptionViewController alloc] initWithNibName:@"SAN_descriptionViewController" bundle:[NSBundle mainBundle]];
        vc.delegate =self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        
        return false;
    }
    else
        return true;
}
-(CGSize)getSizeForText:(NSString *)strText withFont:(UIFont *)font withMaxWidth:(CGFloat)maxWidth
{
    CGSize maxSize = CGSizeMake(maxWidth, 9999);
    CGSize expSize = [strText sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    return expSize;
}
-(void)setDescriptionText:(NSString *)text{

    
    CGRect frame = self.description.frame;
    [self.description setText:text];
    CGSize si = [self getSizeForText:text withFont:self.description.font withMaxWidth:self.description.frame.size.width];
    // had to add extra 20 because it wont fit if not done
    frame.size.height=si.height + 2 * self.description.font.lineHeight;
    self.description.frame = frame;
    
    CGRect f = self.portfolioView.frame;
    f.origin.y = self.description.frame.origin.y + self.description.frame.size.height +20;
    self.portfolioView.frame = f;
    
    f = self.mainView.frame;
    f.size.height = self.portfolioView.frame.origin.y +self.portfolioView.frame.size.height +20;
    self.mainView.frame = f;
    
    self.scrollView.contentSize = f.size;
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.location){
        SAN_addMapViewController *mapVC = [[SAN_addMapViewController alloc] initWithNibName:@"SAN_addMapViewController" bundle:[NSBundle mainBundle]];
        mapVC.delegate =self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mapVC];
        [self presentViewController:nav animated:YES completion:nil];
        
        return false;
    }
    else
        return true;
}
-(void)locationAddress:(CLPlacemark *)pm{
    //if(pm.administrativeArea)
    self.location.text = [NSString stringWithFormat:@" %@-%@-%@",pm.name,pm.country,pm.administrativeArea];
    self.placemark =pm;
}
-(void)saveService{
    //NSLog(@"aa %d",[self.serviceName.text isEqualToString:@""]);
    NSArray *keys = [NSArray arrayWithObjects:@"name",@"description",@"latitude",@"longitude",@"charge",@"timeAvailable",@"categoryIdArray",@"radius",@"locationName",nil];
    NSLog(@"%d",[keys count]);
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    if(![self.serviceName.text isEqualToString:@""])
        [objects addObject:self.serviceName.text];
    else{
        [self alert];
        return;
    }
    if(![self.description.text isEqualToString:@""])
        [objects addObject:self.description.text];
    else{
        [self alert];
        return;
    }
    if(self.placemark !=nil){
        //[objects addObject:[NSString stringWithFormat:@"%f",self.placemark.location.coordinate.latitude]];
        //[objects addObject:[NSString stringWithFormat:@"%f",self.placemark.location.coordinate.longitude]];
        [objects addObject:[NSNumber numberWithFloat:self.placemark.location.coordinate.latitude]];
        [objects addObject:[NSNumber numberWithFloat:self.placemark.location.coordinate.longitude]];
    }
    else{
        [self alert];
        return;
    }
    if(![self.payment.text isEqualToString:@""])
        [objects addObject:self.payment.text];
    else{
        [self alert];
        return;
    }
    if(![self.schedule.text isEqualToString:@""])
        [objects addObject:self.schedule.text];
    else{
        [self alert];
        return;
    }
    if(self.category <20)
        [objects addObject:[NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:self.category], nil]];
    else{
        [self alert];
        return;
    }
    if(self.radius > 0.0f){
        [objects addObject:[NSNumber numberWithFloat:self.radius]];
    }
    else{
        [self alert];
        return;
    }
    if(![self.location.text isEqualToString:@""])
        [objects addObject:self.location.text];
    else{
        [self alert];
        return;
    }
    //[NSArray ]
    //[objects addObject:[[NSArray alloc] initWithObjects:@"nil",@"nil", nil]];
    NSLog(@"operation started");
    NSArray *params = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],self.sessionId, nil];
    SAN_requestToServer *req= [[SAN_requestToServer alloc] initwithObjects:objects keys:keys params:params];
    req.delegate =self;
    //SAN_sendNewServiceToServer *operation = [[SAN_sendNewServiceToServer alloc] initwithObjects:[NSArray arrayWithArray:objects] keys:keys sessionKey:self.sessionId];
    
}
-(void)requestComplete:(NSData *)data{
    NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@" result is %@",strData);
}
-(void)alert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please fill all the fields" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //setting right bar button item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveService)];
    self.navigationItem.rightBarButtonItem = item;
    //setting scroll view
    self.scrollView =[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.backgroundColor = self.mainView.backgroundColor;
    self.scrollView.contentSize = self.mainView.frame.size;
    [self.scrollView addSubview:self.view];
    self.view = self.scrollView;
    
    //setting properties
    self.category = 100;
    self.radius =0.0f;
    self.serviceName.delegate =self;
    self.description.delegate =self;
    self.portfolioImages = [[NSMutableArray alloc] init];
    //setting properties for payment
    self.paymentCurrency = [[NSArray alloc] initWithObjects:@"INR",@"USD",@"ASD", nil];
    self.pvalues = [[values_struct alloc] init];
    self.svalues = [[values_struct alloc] init];
    
    //setting payment textfiled's custom inputview
    self.paymentView = [[SAN_paymentView alloc] init];
    self.paymentView.pickerView.delegate = self;
    [self.paymentView.set addTarget:self action:@selector(paymentSet) forControlEvents:UIControlEventTouchUpInside];
    [self.paymentView.cancel addTarget:self.payment action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [self.payment setInputView:self.paymentView];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 300)];
    v.backgroundColor = [UIColor colorWithWhite:.7 alpha:.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.payment action:@selector(resignFirstResponder)];
    [v addGestureRecognizer:tap];
    self.payment.inputAccessoryView =v;
    
    
    //setting properties for schedule
    
    self.scheduleView = [[SAN_scheduleView alloc] init];
    self.scheduleView.pickerView.delegate =self;
    [self.scheduleView.set addTarget:self action:@selector(scheduleSet) forControlEvents:UIControlEventTouchUpInside];
    [self.scheduleView.cancel addTarget:self.schedule action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [self.schedule setInputView:self.scheduleView];
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 300)];
    v1.backgroundColor = [UIColor colorWithWhite:.7 alpha:.5];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self.schedule action:@selector(resignFirstResponder)];
    [v1 addGestureRecognizer:tap1];
    self.schedule.inputAccessoryView =v1;
    
}
// Picker View delegate and data source methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if(pickerView == self.paymentView.pickerView)
        return 3;
    else
        return 4;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView == self.paymentView.pickerView){
        if(component ==0)
            return 100;
        else if (component ==1)
            return [self.paymentCurrency count];
        else
            return 2;
    }
    else{
        if (component == 0) 
            return 12;
        else if (component == 1)
            return 2;
        else if (component == 2)
            return 12;
        else
            return 2;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(pickerView == self.paymentView.pickerView){
        if(component ==0)
            return 60;
        else if (component ==1)
            return 100;
        else
            return 100;
    }
    else{
        return 60;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView == self.paymentView.pickerView){
        if(component == 0){
            return [NSString stringWithFormat:@"%d",row+1];
        }
        else if (component ==1){
            return self.paymentCurrency[row];
        }
        else{
            if(row == 0)
                return @"HOUR";
            else
                return @"DAY";
        }
    }
    else{
        if(component ==0 || component ==2)
            return [NSString stringWithFormat:@"%d",row +1];
        else{
            if(row == 0)
                return @"AM";
            else
                return @"PM";
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"row = %d component = %d",row,component);
    if(pickerView == self.paymentView.pickerView){
        if(component ==0)
            self.pvalues.row1 = row;
        else if(component ==1)
            self.pvalues.row2 = row;
        if(component ==2)
            self.pvalues.row3 = row;
    }
    else{
        switch (component) {
            case 0:
                self.svalues.row1 = row;
                break;
            case 1:
                self.svalues.row2 = row;
                break;
            case 2:
                self.svalues.row3 = row;
                break;
            case 3:
                self.svalues.row4 = row;
                break;
        }
    }
}



-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectService:(UIButton *)sender {
    SAN_selectServiceViewController *vc = [[SAN_selectServiceViewController alloc] initWithNibName:@"SAN_selectServiceViewController" bundle:[NSBundle mainBundle]];
    vc.delegate =self;
    [self presentViewController:vc animated:YES completion:nil];
    
}
-(void)serviceIconSelected:(NSUInteger)index{
    NSLog(@"%d",index);
    self.category = index;
    [self.serviceIconButton setTitle:@"" forState:UIControlStateNormal];
    [self.serviceIconButton setBackgroundColor:nil];
    UIImage *img;
    if(index == 0)
        img = [UIImage imageNamed:@"filter_art_design_icon.png"];
    else if (index ==1)
        img = [UIImage imageNamed:@"filter_finance_icon.png"];
    else if (index ==2)
        img = [UIImage imageNamed:@"filter_entertainment_icon.png"];
    else if (index ==3)
        img = [UIImage imageNamed:@"filter_sales_marketing_icon.png"];
    else if (index ==4)
        img = [UIImage imageNamed:@"filter_service_icon.png"];
    else if (index ==5)
        img = [UIImage imageNamed:@"filter_manufacturing_icon.png"];
    else if (index ==6)
        img = [UIImage imageNamed:@"filter_health_icon.png"];
    else if (index ==7)
        img = [UIImage imageNamed:@"filter_housekeeping_icon.png"];
    else if (index ==8)
        img = [UIImage imageNamed:@"filter_science_tech_icon.png"];
    else
        img = [UIImage imageNamed:@"filter_other_icon.png"];
    [self.serviceIconButton setBackgroundImage:img forState:UIControlStateNormal];
    
}
- (IBAction)milesSelected:(UIButton *)sender {
    self.mi_1.backgroundColor = [UIColor whiteColor];
    self.mi_2.backgroundColor = [UIColor whiteColor];
    self.mi_3.backgroundColor = [UIColor whiteColor];
    self.mi_4.backgroundColor = [UIColor whiteColor];
    if(sender == self.mi_1){
        self.mi_1.backgroundColor = [UIColor redColor];
        self.radius = 0.5 * METERS_PER_MILE;
    }
    else if (sender == self.mi_2){
        self.mi_2.backgroundColor = [UIColor redColor];
        self.radius = 3.0 * METERS_PER_MILE;
    }
    else if (sender == self.mi_3){
        self.mi_3.backgroundColor = [UIColor redColor];
        self.radius = 10.0f * METERS_PER_MILE;
    }
    else{
        self.mi_4.backgroundColor = [UIColor redColor];
        self.radius = 25.0f * METERS_PER_MILE;
    }
}


- (IBAction)addPortfolioImage:(UIButton *)sender {
    NSLog(@"clicked");
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.delegate =self;
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    
    UIImageView *v =[[UIImageView alloc] initWithFrame:self.portfolioButton.frame];
    v.contentMode = UIViewContentModeScaleAspectFit;
    [v setImage:image];
    
    [self.portfolioView addSubview:v];
    [self.portfolioImages addObject:v];
    
    
    NSInteger row = [self.portfolioImages count]/4;
    NSInteger column = [self.portfolioImages count]%4;
    NSLog(@"row %d column %d",row,column);
    CGRect frame = self.portfolioButton.frame;
    frame.origin.x = 25 + (column * (10+60));
    frame.origin.y = 30 + (row+1)*10 + row*60 ;
    NSLog(@" %f %f",frame.origin.x,frame.origin.y);
    [self.portfolioButton setFrame:frame];
    
    CGRect f = self.portfolioView.frame;
    f.size.height = self.portfolioButton.frame.origin.y + self.portfolioButton.frame.size.height +10;
    self.portfolioView.frame =f;
    
    f=self.mainView.frame;
    f.size.height = self.portfolioView.frame.origin.y +self.portfolioView.frame.size.height;
    self.mainView.frame = f;
    
    self.scrollView.contentSize = f.size;
    
    [picker dismissModalViewControllerAnimated:YES];
    
}
@end
















