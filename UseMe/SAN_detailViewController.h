//
//  SAN_detailViewController.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/30/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAN_requestToServer.h"
#import "SAN_Cell1.h"
#import "SAN_Cell2.h"
@interface SAN_detailViewController : UITableViewController<SAN_requestToServerProtocol>
@property NSUInteger sid;
@end
