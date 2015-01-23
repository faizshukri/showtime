//
//  Movie.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Movie.h"
#import "APIHelper.h"
#import "Review.h"

@implementation Movie

-(id) initWithData:(NSDictionary*)data {
    self = [super init];
    
    if(self){
        _movieId     = [[data objectForKey:@"id"] intValue];
        _title       = [data objectForKey:@"title"];
        _synopsis    = [data objectForKey:@"synopsis"];
        _thumbnail   = [APIHelper getThumbWithURL:[[data objectForKey:@"posters"] objectForKey:@"thumbnail"]];
        _genres      = [data objectForKey:@"genres"];
        _mpaa_rating = [data objectForKey:@"mpaa_rating"];
        _ratings     = [NSString stringWithFormat:@"%1.2f ratings", [[[data objectForKey:@"ratings"] objectForKey:@"critics_score"] intValue] / 10.0 ];
        
        NSMutableArray *castTmp = [[NSMutableArray alloc] init];
        for (NSDictionary *obj in (NSArray*)[data objectForKey:@"abridged_cast"]) {
            [castTmp addObject:[NSString stringWithFormat:@"* %@ - %@", [obj objectForKey:@"name"], [[obj objectForKey:@"characters"] componentsJoinedByString:@","]]];
        }
        _cast        = castTmp;
    
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _release_date = [dateFormat dateFromString:[[data objectForKey:@"release_dates"] objectForKey:@"theater"]];
        
        _pageURL = [NSURL URLWithString:[[data objectForKey:@"links"] objectForKey:@"alternate"]];
    }
 
    return self;
}

-(NSArray *)reviews{
    NSArray *reviewData = [APIHelper getReviewOfMovie:_movieId];
    
    NSMutableArray *reviews = [[NSMutableArray alloc] init];
    
    for (NSDictionary *data in reviewData) {
        Review *review = [[Review alloc] initWithData:data];
        [reviews addObject:review];
    }
    
    return (NSArray*) reviews;
}

@end
