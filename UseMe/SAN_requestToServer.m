//
//  SAN_requestToServer.m
//  UseMe
//
//  Created by Santhosh Kumar on 9/2/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//
#define GET_SERVICE_DETAILS_API_ADDRESS @"http://54.218.57.170/api/v1/service/getservice/detail"
#define ADD_SERVICE @"http://192.168.1.125:4000/api/v1/service/addservice"
#import "SAN_requestToServer.h"

@implementation SAN_requestToServer

-(id)initwithObjects:(NSArray *)objects keys:(NSArray *)keys params:(NSArray *)params{
    
    NSInteger type = [[params objectAtIndex:0] integerValue];
    
    if(type == 1){
        NSInteger sid = [[params objectAtIndex:1] integerValue];
        //if any error check api address ip value
        NSString *urlString = [NSString  stringWithFormat:@"%@?sid=%d",GET_SERVICE_DETAILS_API_ADDRESS,sid];
        NSLog(@"url string is  %@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (connection) {
            self.data = [[NSMutableData alloc] init];
            
        }
    }
    
    else{
        NSString *sessionKey = [params objectAtIndex:1];
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
    NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"data loaded");
    //data ready to be use
    if(connection) {
        [connection cancel];
        connection = nil;
    }
    //NSString *strData = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    //NSLog(@"printStr is %@", strData);
    [self.delegate requestComplete:self.data];
    
}




@end
