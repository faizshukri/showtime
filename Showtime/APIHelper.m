//
//  APIHelper.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

+(NSString*) apikey {
    return @"3hygztm99p9ermrfa2gp8dan";
}

+(NSArray*)getShowingMoviesWithLimit:(int)limit atPage:(int)page filterLocation:(NSString*)countryCode {
    
    // Set default country code to US
    if(countryCode == nil) countryCode = @"us";
    // Set country code to be lowercase
    else countryCode = [countryCode lowercaseString];
    
    // Build the url string
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&page_limit=%d&page=%d&country=%@",
                           [APIHelper apikey],
                           limit,
                           page,
                           countryCode];
    
    // Get the json data from the url string
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if(jsonData==nil){
        NSLog(@"No data returned");
    }
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    // Return movies array object
    return (NSArray*)[result objectForKey:@"movies"];
}

+(Movie*)getMovieInfoById:(int)movieId {
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%d.json?apikey=%@", movieId, [APIHelper apikey]];
    
    // Get the json data from the url string
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if(jsonData==nil){
        NSLog(@"No data returned");
    }
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    // Return movies array object
    return [[Movie alloc] initWithData:result];
}

+(NSArray*)getSimilarById:(int)movieId {
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%d/similar.json?apikey=%@&limit=3", movieId, [APIHelper apikey]];
    
    // Get the json data from the url string
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if(jsonData==nil){
        NSLog(@"No data returned");
    }
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    // Return movies array object
    return (NSArray*)[result objectForKey:@"movies"];
}

+(UIImage*)getThumbWithURL:(NSString *)url{
        
        url = [url stringByReplacingOccurrencesOfString:@"tmb.jpg" withString:@"pro.jpg"];
        NSURL *imageString = [NSURL URLWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageString];
    
        return [[UIImage alloc] initWithData:imageData];
}

@end
