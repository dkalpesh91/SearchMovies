//
//  NetworkHelper.m
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 21/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import "NetworkHelper.h"
static const NSString *APIURL = @"http://www.omdbapi.com/";

@interface NetworkHelper ()

@end

@implementation NetworkHelper

- (NSURLSession *)dataSession {
    static NSURLSession *defaultSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return defaultSession;
}


#pragma mark - General Methods

- (NSMutableURLRequest *)requestFromURLStringGet:(NSURL *)url{
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Specify that it will be a GET request
    request.HTTPMethod = @"GET";
    
    request.timeoutInterval = 60.0;
    
    // This is how we set header fields
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

-(void)getMoviesListAPICall:(NSDictionary *)data{
    
            NSURLComponents *components = [NSURLComponents componentsWithString:[NSString stringWithFormat:@"%@", APIURL]];
            
            NSMutableArray *queryItems = [NSMutableArray array];
            for (NSString *key in data) {
                [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:data[key]]];
            }
            components.queryItems = queryItems;
            
            NSString *urlString = [NSString stringWithFormat:@"%@", APIURL];
            
            NSLog(@"url : %@", urlString);
            
            NSMutableURLRequest *request = [self requestFromURLStringGet:components.URL];
            
            NSLog(@"request : %@", request);
            
        NSURLSessionDataTask *datatask = [[self dataSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(searchMoviesCallErrorCallback:)]) {
                    [self.delegate searchMoviesCallErrorCallback:error];
                }
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(searchMoviesCallApicallSuccess:)]) {
                    NSMutableData * mutableData = [NSMutableData dataWithData:data];
                    [self.delegate searchMoviesCallApicallSuccess:mutableData];
                }
            });
        }
        }];
    
    [datatask resume];
}

@end
