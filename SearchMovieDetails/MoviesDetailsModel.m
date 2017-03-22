//
//  MoviesDetailsModel.m
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 22/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import "MoviesDetailsModel.h"

@implementation MoviesDetailsModel

+(instancetype)getMoviesDetailsFromDictionary:(NSDictionary *)dict{
    
    // create new Entity
    MoviesDetailsModel *item = [[MoviesDetailsModel alloc]init];
    
    item.title                  = dict[@"Title"] != nil ? dict[@"Title"]:@"N/A";
    item.year                  = dict[@"Year"] != nil ? dict[@"Year"]:@"N/A";
    item.rated                  = dict[@"Rated"] != nil ? dict[@"Rated"]:@"N/A";
    item.released                  = dict[@"Released"] != nil ? dict[@"Released"]:@"N/A";
    item.runtime                  = dict[@"Runtime"] != nil ? dict[@"Runtime"]:@"N/A";
    item.genre                  = dict[@"Genre"] != nil ? dict[@"Genre"]:@"N/A";
    item.director                  = dict[@"Director"] != nil ? dict[@"Director"]:@"N/A";
    item.writer                  = dict[@"Writer"] != nil ? dict[@"Writer"]:@"N/A";
    item.actors                  = dict[@"Actors"] != nil ? dict[@"Actors"]:@"N/A";
    item.plot                  = dict[@"Plot"] != nil ? dict[@"Plot"]:@"N/A";
    item.language                  = dict[@"Language"] != nil ? dict[@"Language"]:@"N/A";
    item.country                  = dict[@"Country"] != nil ? dict[@"Country"]:@"N/A";
    item.awards                  = dict[@"Awards"] != nil ? dict[@"Awards"]:@"N/A";
    item.poster                  = dict[@"Poster"];
    item.metascore                  = dict[@"Metascore"] != nil ? dict[@"Metascore"]:@"N/A";
    item.imdbRating                  = dict[@"imdbRating"] != nil ? dict[@"imdbRating"]:@"N/A";
    item.imdbVotes                  = dict[@"imdbVotes"] != nil ? dict[@"imdbVotes"]:@"N/A";
    item.imdbID                  = dict[@"imdbID"] != nil ? dict[@"imdbID"]:@"N/A";
    item.type                  = dict[@"Type"] != nil ? dict[@"Type"]:@"N/A";
    item.response                  = dict[@"Response"] != nil ? dict[@"Response"]:@"N/A";
    
    
    return item;
}


@end
