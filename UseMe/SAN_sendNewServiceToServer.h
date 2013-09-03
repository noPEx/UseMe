//
//  SAN_sendNewServiceToServer.h
//  UseMe
//
//  Created by Santhosh Kumar on 8/29/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAN_sendNewServiceToServer : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate>
-(id)initwithObjects:(NSArray *)objects keys:(NSArray *)keys sessionKey:(NSString *)sessionKey;
@property NSMutableData *data;
@end
