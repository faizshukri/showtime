//
//  Movies.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Movies.h"
#import "Movie.h"
#import "Thumb.h"
#import "APIHelper.h"

@implementation Movies

-(id)initWithLimit:(int)limit andPage:(int)page{
    
    self = [super init];
    
    if(self){
        _movies = [APIHelper getShowingMoviesWithLimit:limit atPage:page filterLocation:nil];
    }
    
    return self;
}

-(NSArray*)getThumbArray{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    for (int movie = 0; movie < _movies.count; movie++) {
        
        NSString *thumbUrl = (NSString*) [[[_movies objectAtIndex:movie] objectForKey:@"posters"] objectForKey:@"thumbnail"];
        [images addObject:[[Thumb alloc] initWithUrl:thumbUrl]];
    }
    return images;
}

-(NSArray*)getMovies{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (int movie = 0; movie < _movies.count; movie++) {
        Movie *tmp = [[Movie alloc] init];
        tmp.title     = (NSString*) [[_movies objectAtIndex:movie] objectForKey:@"title"];
        tmp.synopsis  = (NSString*) [[_movies objectAtIndex:movie] objectForKey:@"synopsis"];
        tmp.thumbnail = [[Thumb alloc] initWithUrl:[[[_movies objectAtIndex:movie] objectForKey:@"posters"] objectForKey:@"thumbnail"]];
        [movies addObject:tmp];
    }
    return movies;
}

@end
