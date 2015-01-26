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

// Both of this (initWithCoder and encodeWithCoder) are needed for Object Archive
-(id)initWithCoder:(NSCoder *)encoder
{
    self = [super init];
    if (self) {
        self.movieId      = [encoder decodeIntForKey:@"movieId"];
        self.title        = [encoder decodeObjectForKey:@"title"];
        self.thumbnail    = [encoder decodeObjectForKey:@"thumbnail"];
        self.synopsis     = [encoder decodeObjectForKey:@"synopsis"];
        self.genres       = [encoder decodeObjectForKey:@"genres"];
        self.mpaa_rating  = [encoder decodeObjectForKey:@"mpaa_rating"];
        self.ratings      = [encoder decodeObjectForKey:@"ratings"];
        self.cast         = [encoder decodeObjectForKey:@"cast"];
        self.release_date = [encoder decodeObjectForKey:@"release_date"];
        self.pageURL      = [encoder decodeObjectForKey:@"pageURL"];
        self.reviews      = [encoder decodeObjectForKey:@"reviews"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeInt:self.movieId forKey:@"movieId"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.thumbnail forKey:@"thumbnail"];
    [encoder encodeObject:self.synopsis forKey:@"synopsis"];
    [encoder encodeObject:self.genres forKey:@"genres"];
    [encoder encodeObject:self.mpaa_rating forKey:@"mpaa_rating"];
    [encoder encodeObject:self.ratings forKey:@"ratings"];
    [encoder encodeObject:self.cast forKey:@"cast"];
    [encoder encodeObject:self.release_date forKey:@"release_date"];
    [encoder encodeObject:self.pageURL forKey:@"pageURL"];
    [encoder encodeObject:self.reviews forKey:@"reviews"];
}

// Initialize Movie with JSON data downloaded from API
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
        
        // API return cast object in array. We create the string and make is as array first.
        NSMutableArray *castTmp = [[NSMutableArray alloc] init];
        for (NSDictionary *obj in (NSArray*)[data objectForKey:@"abridged_cast"]) {
            [castTmp addObject:[NSString stringWithFormat:@"* %@ - %@", [obj objectForKey:@"name"], [[obj objectForKey:@"characters"] componentsJoinedByString:@","]]];
        }
        _cast        = castTmp;
    
        // Store release date as NSDate
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _release_date = [dateFormat dateFromString:[[data objectForKey:@"release_dates"] objectForKey:@"theater"]];
        
        _pageURL = [NSURL URLWithString:[[data objectForKey:@"links"] objectForKey:@"alternate"]];
    }
 
    return self;
}

// By default, reviews is null. Only populated once called.
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
