//
//  Movie.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Movie.h"
#import "APIHelper.h"

@implementation Movie

-(id) initWithData:(NSDictionary*)data {
    self = [super init];
    
    if(self){
        _movieId   = (int)[data objectForKey:@"id"];
        _title     = [data objectForKey:@"title"];
        _title     = [data objectForKey:@"title"];
        _synopsis  = [data objectForKey:@"synopsis"];
        _thumbnail = [APIHelper getThumbWithURL:[[data objectForKey:@"posters"] objectForKey:@"thumbnail"]];
        _genres    = [data objectForKey:@"genres"];
    }
 
    return self;
}

@end
