//
//  Movies.h
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MOVIE_SHOWING,
    MOVIE_UPCOMING
} MovieType;

@interface Movies : NSObject {
    int _limit;
    MovieType _movieType;
}

@property NSArray *movies;
-(id)initWithLimit:(int)limit andPage:(int)page movieType:(MovieType)type;
-(NSArray*)getMovies;
-(NSArray*)getMoviesAtPage:(int)page;
-(NSArray*)getSimilarMoviesByID:(int)movieId;
@end
