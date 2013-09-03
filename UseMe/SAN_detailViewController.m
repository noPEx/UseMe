//
//  SAN_detailViewController.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/30/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_detailViewController.h"

@interface SAN_detailViewController ()
@property SAN_Cell1 *cell1;
@property SAN_Cell2 *cell2;
@property NSArray *imgLinks;
@property BOOL requestComplete;
//@property NSArray *categoryIconLinks;
@property NSDictionary *categoryIconLinks;
@end

@implementation SAN_detailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)requestComplete:(NSData *)data{
    NSLog(@"response %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if([[dic objectForKey:@"success"] boolValue] == false){
        NSLog(@"response not successful");
        return;
    }
    self.cell1 = [[SAN_Cell1 alloc] init];
    NSDictionary *details = [dic objectForKey:@"data"];
    self.cell1.category.text = [details objectForKey:@"category_name"];
    self.cell1.categoryIcon.image = [UIImage imageNamed:[self.categoryIconLinks objectForKey:[details objectForKey:@"category_name"]]];
    self.cell1.serviceName.text = [details objectForKey:@"name"];
    self.cell1.personName.text = [NSString stringWithFormat:@"%@ %@",[details objectForKey:@"first_name"],[details objectForKey:@"last_name"]];
    self.cell1.location.text = [details objectForKey:@"location_name"];
    self.cell1.description.text = [details objectForKey:@"description"];
    self.cell1.availableTime.text = [details objectForKey:@"time_available"];
    self.cell1.pay.text = [details objectForKey:@"charge"];
    
    
    
    NSString *profileImageLink = [details objectForKey:@"profile_image_link"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
        NSURL *url = [[NSURL alloc] initWithString:profileImageLink];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cell1.profileImage.image = [[UIImage alloc] initWithData:data];
        });
        
    });
    
    
    self.imgLinks = [details objectForKey:@"imageLinkArray"];
    self.cell2 = [[SAN_Cell2 alloc] init:[self.imgLinks count]];

    for(NSUInteger i=0;i<[self.imgLinks count];i++){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
            NSURL *url = [[NSURL alloc] initWithString:[self.imgLinks objectAtIndex:i]];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *v = [self.cell2.imageArray objectAtIndex:i];
                UIImage *img = [[UIImage alloc] initWithData:data];
                v.image = img;
                NSLog(@"image loaded at index %d",i);
                //[self.cell2 setNeedsLayout];
                //[self.tableView reloadData];
            });
            
        });
    }
    
    self.requestComplete =true;
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.requestComplete = false;
    //self.categoryIconLinks = [NSArray arrayWithObjects:@"filter_art_design_icon.png",@"filter_finance_icon.png",@"filter_entertainment_icon.png",@"filter_sales_marketing_icon.png",@"filter_service_icon.png",@"filter_manufacturing_icon.png",@"filter_health_icon.png",@"filter_housekeeping_icon.png",@"filter_science_tech_icon.png",@"filter_other_icon.png", nil];
    //self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.categoryIconLinks = [NSDictionary dictionaryWithObjectsAndKeys:@"filter_art_design_icon.png",@"Art & Design",@"filter_finance_icon.png",@"Finance",@"filter_entertainment_icon.png",@"Entertainment",@"filter_sales_marketing_icon.png",@"Sales & Marketing",@"filter_service_icon.png",@"Service",@"filter_manufacturing_icon.png",@"Manufacturing",@"filter_health_icon.png",@"Health",@"filter_housekeeping_icon.png",@"Housekeeping",@"filter_science_tech_icon.png",@"Science & Tech",@"filter_other_icon.png",@"Other",@"filter_housekeeping_icon.png",@"Housework", nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1];
    //request to server
    NSArray *paramsArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:self.sid], nil];
    SAN_requestToServer *req = [[SAN_requestToServer alloc] initwithObjects:nil keys:nil params:paramsArray];
    req.delegate =self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.requestComplete)
        return 1;
    else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = 10;
    switch (indexPath.row) {
        case 0:
            h = self.cell1.frame.size.height;
            break;
        case 1:
            h = self.cell2.frame.size.height;
            break;
    }
    return h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell;
    if(indexPath.row == 0)
        cell = self.cell1;
    else
        cell =self.cell2;
    
    return cell;
}




@end





