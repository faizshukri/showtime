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
    
    if(countryCode == nil) countryCode = @"us";
    else countryCode = [countryCode lowercaseString];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&page_limit=%d&page=%d&country=%@", [APIHelper apikey], limit, page, countryCode];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    if(jsonData==nil){
        NSLog(@"No data returned");
    }
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    return (NSArray*)[result objectForKey:@"movies"];
}

@end
