//
//  MoviesTests.m
//  Showtime
//
//  Created by Faiz Shukri on 1/25/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Movies.h"
#import "Movie.h"

@interface MoviesTests : XCTestCase
@property Movies *movies;
@end

@implementation MoviesTests
@synthesize movies;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    movies = [[Movies alloc] initWithLimit:3 andPage:1 movieType:MOVIE_SHOWING];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testMoviePropertyNotHoldArrayOfMovie{
    
    // movies property hold array of data, and not array of Movie
    XCTAssertFalse([(Movie*)[movies.movies objectAtIndex:0] isKindOfClass:[Movie class]]);
    
    NSArray *movieArray = [movies getMovies];
    
    // getMovies hold array Movie
    XCTAssertTrue([(Movie*)[movieArray objectAtIndex:0] isKindOfClass:[Movie class]]);
}

-(void)testDateOfMovieIsCorrect{
    
    NSArray *movieArray = [movies getMovies];
    
    // Type MOVIE_SHOWING should return movie that already been release
    for(Movie *mv in movieArray){
        XCTAssertEqual([mv.release_date compare:[NSDate date]], NSOrderedAscending);
    }
    
    movies = [[Movies alloc] initWithLimit:2 andPage:1 movieType:MOVIE_UPCOMING];
    movieArray = [movies getMovies];
    
    // Type MOVIE_UPCOMING shoud return movie that not been release yet
    for(Movie *mv in movieArray){
        XCTAssertEqual([mv.release_date compare:[NSDate date]], NSOrderedDescending);
    }
}

@end
