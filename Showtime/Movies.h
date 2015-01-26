//
//  Movies.h
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MovieType) {
    MOVIE_SHOWING,
    MOVIE_UPCOMING
};

@interface Movies : NSObject {
    int _limit;
    MovieType _movieType;
}

@property NSArray *movies;

-(id)initWithLimit:(int)limit andPage:(int)page movieType:(MovieType)type;
-(NSArray*)getMovies;
-(NSDictionary*)getMoviesInSections;
-(NSArray*)getMoviesAtPage:(int)page;
-(NSDictionary*)getMoviesInSectionsAtPage:(int)page;
-(NSArray*)getSimilarMoviesByID:(int)movieId;
@end
