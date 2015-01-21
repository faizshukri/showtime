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
-(id)initWithLimit:(int)limit andPage:(int)page{
    
    self = [super init];
    
    if(self){
        _limit = limit;
        _movies = [APIHelper getShowingMoviesWithLimit:limit atPage:page filterLocation:nil];
    }
    
    return self;
}

-(NSArray*)getMovies{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (int movie = 0; movie < _movies.count; movie++) {
        Movie *tmp = [[Movie alloc] initWithData:[_movies objectAtIndex:movie]];
        [movies addObject:tmp];
    }
    return movies;
}

-(NSArray*)getMoviesAtPage:(int)page {
    _movies = [APIHelper getShowingMoviesWithLimit:_limit atPage:page filterLocation:nil];
    
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (int movie = 0; movie < _movies.count; movie++) {
        Movie *tmp = [[Movie alloc] initWithData:[_movies objectAtIndex:movie]];
        [movies addObject:tmp];
    }
    return movies;
}

-(NSArray*)getSimilarMoviesByID:(int)movieId{
    
    NSArray *similarMovies = [APIHelper getSimilarById:movieId];
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (int movie = 0; movie < similarMovies.count; movie++) {
        Movie *tmp = [[Movie alloc] initWithData:[similarMovies objectAtIndex:movie]];
        [movies addObject:tmp];
    }
    return movies;
}

@end
