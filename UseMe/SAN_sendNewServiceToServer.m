//
//  SAN_sendNewServiceToServer.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/29/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_sendNewServiceToServer.h"
#define ADD_SERVICE @"http://192.168.1.125:4000/api/v1/service/addservice"
@implementation SAN_sendNewServiceToServer

-(id)initwithObjects:(NSArray *)objects keys:(NSArray *)keys sessionKey:(NSString *)sessionKey{
    NSURL *url = [NSURL URLWithString:ADD_SERVICE];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    
    if (!jsonData) {
        NSLog(@"JSON ERror %@", error);
    }
    else {
        NSLog(@"JSON data created");
    }
    
    NSString *postData = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:sessionKey forHTTPHeaderField:@"session-key"];
    [request setHTTPBody:jsonData];
    [request setValue:[NSString stringWithFormat:@"%i", postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPShouldHandleCookies:YES];
    [request setTimeoutInterval:30];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        self.data = [[NSMutableData alloc] init];
        
    }

    
    
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"rep %@",response);
    [self.data setLength:0];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //NSLog(@"data");
    [self.data appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"data loaded");
    //data ready to be use
    if(connection) {
        [connection cancel];
        connection = nil;
    }
    NSString *strData = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"printStr is %@", strData);
    
}



@end
