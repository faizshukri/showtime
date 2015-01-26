//
//  ApiHelperTests.m
//  Showtime
//
//  Created by Faiz Shukri on 1/25/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "APIHelper.h"
#import "Movie.h"

@interface ApiHelperTests : XCTestCase

@end

@implementation ApiHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGetJsonByUrlString{
    NSDictionary *result = [APIHelper getJsonByUrlString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=3hygztm99p9ermrfa2gp8dan&page_limit=1&page=3&country=us"];
    
    XCTAssertTrue([result objectForKey:@"movies"]);
}

-(void)testGetShowingMoviesWithLimit{
    NSArray *movies = [APIHelper getShowingMoviesWithLimit:1 atPage:1 filterLocation:nil];
    XCTAssertEqual(movies.count, 1);
    
    movies = [APIHelper getShowingMoviesWithLimit:2 atPage:1 filterLocation:nil];
    XCTAssertEqual(movies.count, 2);
}

-(void)testGetMovieInfoById{
    Movie *movie = [APIHelper getMovieInfoById:771366367];
    XCTAssertEqual(movie.movieId, 771366367);
}

-(void)testGetReviewOfMovie{
    NSArray *reviews = [APIHelper getReviewOfMovie:771366367];
    XCTAssertTrue([[reviews objectAtIndex:0] objectForKey:@"critic"]);
}
@end
