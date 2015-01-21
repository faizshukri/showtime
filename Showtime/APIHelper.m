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

+(NSDictionary*)getResultByUrlString:(NSString*)urlString{
    // Get the json data from the url string
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if(jsonData==nil){
        NSLog(@"No data returned");
    }
    
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
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
    
    NSDictionary *result = [APIHelper getResultByUrlString:urlString];
    
    // Return movies array object
    return (NSArray*)[result objectForKey:@"movies"];
}

+(NSArray*)getUpcomingMoviesWithLimit:(int)limit atPage:(int)page{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=%@&page_limit=%d&page=%d", [APIHelper apikey], limit, page];
    
    NSDictionary *result = [APIHelper getResultByUrlString:urlString];
    
    // Return movies array object
    return (NSArray*)[result objectForKey:@"movies"];
}

+(Movie*)getMovieInfoById:(int)movieId {
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%d.json?apikey=%@", movieId, [APIHelper apikey]];
    
    NSDictionary *result = [APIHelper getResultByUrlString:urlString];
    
    // Return movies array object
    return [[Movie alloc] initWithData:result];
}

+(NSArray*)getSimilarMovieById:(int)movieId {
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%d/similar.json?apikey=%@&limit=3", movieId, [APIHelper apikey]];
    
    NSDictionary *result = [APIHelper getResultByUrlString:urlString];
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
