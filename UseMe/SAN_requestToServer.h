//
//  SAN_requestToServer.h
//  UseMe
//
//  Created by Santhosh Kumar on 9/2/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SAN_requestToServer;
@protocol SAN_requestToServerProtocol <NSObject>
-(void)requestComplete:(NSData *)data;

@end

@interface SAN_requestToServer : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
-(id)initwithObjects:(NSArray *)objects keys:(NSArray *)keys params:(NSArray *)params;
@property NSMutableData *data;
@property id<SAN_requestToServerProtocol> delegate;
@end
