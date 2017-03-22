//
//  NetworkHelper.h
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 21/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkHelperDelegate;

@interface NetworkHelper : NSObject

- (void)getMoviesListAPICall:(NSDictionary *)data;

@property (nonatomic, weak) id<NetworkHelperDelegate> delegate;

@end

@protocol NetworkHelperDelegate <NSObject>

@optional
- (void)searchMoviesCallApicallSuccess:(NSMutableData *)data;
- (void)searchMoviesCallErrorCallback:(NSError *)error;

@end
