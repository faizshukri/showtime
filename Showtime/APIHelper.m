//
//  APIHelper.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

// Return API Key
+(NSString*) apikey {
    return @"3hygztm99p9ermrfa2gp8dan";
}

// Get JSON return by API as NSDictionary
+(NSDictionary*)getJsonByUrlString:(NSString*)urlString{
    // Get the json data from the url string
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if(jsonData==nil){
        NSLog(@"No data returned");
    }
    
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
}

// Get now showing movies with limit, page and location filter
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
    
    NSDictionary *result = [APIHelper getJsonByUrlString:urlString];
    
    // Total movie return by API
    int total = (int) [[result objectForKey:@"total"] intValue];
    
    // Maximum page needed, as API will circle page back to the beginning
    int maxPage = (total+limit-1)/limit;
    
    NSMutableArray* object = [[NSMutableArray alloc] init];
    
    // We only add the result if page is not exceed maxpage
    if(page <= maxPage){
        [object addObjectsFromArray:[result objectForKey:@"movies"]];
    }
    
    // Return movies array object
    return (NSArray*) object;
}

// Get upcoming movies with limit and page
+(NSArray*)getUpcomingMoviesWithLimit:(int)limit atPage:(int)page{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=%@&page_limit=%d&page=%d", [APIHelper apikey], limit, page];
    
    NSDictionary *result = [APIHelper getJsonByUrlString:urlString];
    
    int total = (int) [[result objectForKey:@"total"] intValue];
    int maxPage = (total+limit-1)/limit;
    
    NSMutableArray* object = [[NSMutableArray alloc] init];
    
    if(page <= maxPage){
        [object addObjectsFromArray:[result objectForKey:@"movies"]];
    }
    // Return movies array object
    return (NSArray*) object;
}

// Get movie by movie id
+(Movie*)getMovieInfoById:(int)movieId {
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%d.json?apikey=%@", movieId, [APIHelper apikey]];
    
    NSDictionary *result = [APIHelper getJsonByUrlString:urlString];
    
    // Return movies array object
    return [[Movie alloc] initWithData:result];
}

// Get similar movie by movie id
+(NSArray*)getSimilarMovieById:(int)movieId {
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%d/similar.json?apikey=%@&limit=3", movieId, [APIHelper apikey]];
    
    NSDictionary *result = [APIHelper getJsonByUrlString:urlString];
    // Return movies array object
    return (NSArray*)[result objectForKey:@"movies"];
}

// Get thumb by url as UIImage
+(UIImage*)getThumbWithURL:(NSString *)url{
    
        // By default, thumbnail property will all return thumb size which is quite small. We force to get a medium by replace tmb with pro
        url = [url stringByReplacingOccurrencesOfString:@"tmb.jpg" withString:@"pro.jpg"];
        NSURL *imageString = [NSURL URLWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageString];
    
        return [[UIImage alloc] initWithData:imageData];
}

// Get movie review by movie id
+(NSArray*) getReviewOfMovie:(int)movieId {
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%d/reviews.json?apikey=%@", movieId, [APIHelper apikey]];
    
    NSDictionary *result = [APIHelper getJsonByUrlString:urlString];
    return (NSArray*)[result objectForKey:@"reviews"];
}

@end
