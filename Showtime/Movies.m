//
//  Movies.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Movies.h"
#import "Movie.h"
#import "APIHelper.h"

@implementation Movies

-(id)init{
    self = [super init];
    
    if(self){
        _limit = 15;
    }
    
    return self;
}
-(id)initWithLimit:(int)limit andPage:(int)page movieType:(MovieType)type{
    
    self = [super init];
    
    if(self){
        _limit = limit;
        _movieType = type;
        
        if(_movieType == MOVIE_UPCOMING){
            _movies = [APIHelper getUpcomingMoviesWithLimit:_limit atPage:page];
        } else {
            _movies = [APIHelper getShowingMoviesWithLimit:limit atPage:page filterLocation:nil];
        }
    }
    
    return self;
}

 // Return array of movies in one level
-(NSArray*)getMovies{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (int movie = 0; movie < _movies.count; movie++) {
        Movie *tmp = [[Movie alloc] initWithData:[_movies objectAtIndex:movie]];
        [movies addObject:tmp];
    }
    return movies;
}

 // Return array of movies, structured into several section array
-(NSDictionary*)getMoviesInSections{
    
    NSMutableDictionary *section = [[NSMutableDictionary alloc] init];
    
    for (int movie = 0; movie < _movies.count; movie++) {
        Movie *tmp = [[Movie alloc] initWithData:[_movies objectAtIndex:movie]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM yyyy"];
        
        NSString *sectionTitle = [dateFormatter stringFromDate:tmp.release_date ];
        
        if([section objectForKey:sectionTitle]){
            // Dictionary has array of movies
            [(NSMutableArray*)[section objectForKey:sectionTitle] addObject:tmp];
        } else {
            // First item in the section
            NSMutableArray *newSection = [[NSMutableArray alloc] init];
            [newSection addObject:tmp];
            
            [section setObject:newSection forKey:sectionTitle];
        }
    }
    
    return section;
}

-(NSArray*)getMoviesAtPage:(int)page {
    
    if(_movieType == MOVIE_UPCOMING) _movies =[APIHelper getUpcomingMoviesWithLimit:_limit atPage:page];
    else                             _movies =[APIHelper getShowingMoviesWithLimit:_limit atPage:page filterLocation:nil];
    
    return [self getMovies];
}

-(NSDictionary *)getMoviesInSectionsAtPage:(int)page{
    _movies = [APIHelper getUpcomingMoviesWithLimit:_limit atPage:page];
    return [self getMoviesInSections];
}

-(NSArray*)getSimilarMoviesByID:(int)movieId{
    
    NSArray *similarMovies = [APIHelper getSimilarMovieById:movieId];
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (int movie = 0; movie < similarMovies.count; movie++) {
        Movie *tmp = [[Movie alloc] initWithData:[similarMovies objectAtIndex:movie]];
        [movies addObject:tmp];
    }
    return movies;
}

@end
