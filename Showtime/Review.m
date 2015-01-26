//
//  Review.m
//  Showtime
//
//  Created by Faiz Shukri on 1/23/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Review.h"

@implementation Review

// Both of this (initWithCoder and encodeWithCoder) are needed for Object Archive
-(id)initWithCoder:(NSCoder *)encoder{
    self = [super init];
    if(self){
        self.critic      = [encoder decodeObjectForKey:@"critic"];
        self.date        = [encoder decodeObjectForKey:@"date"];
        self.freshness   = [encoder decodeObjectForKey:@"freshness"];
        self.publication = [encoder decodeObjectForKey:@"publication"];
        self.quote       = [encoder decodeObjectForKey:@"quote"];
        self.link        = [encoder decodeObjectForKey:@"link"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.critic forKey:@"critic"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.freshness forKey:@"freshness"];
    [encoder encodeObject:self.publication forKey:@"publication"];
    [encoder encodeObject:self.quote forKey:@"quote"];
    [encoder encodeObject:self.link forKey:@"link"];
}

// Initialize Review with JSON data downloaded from API
-(id)initWithData:(NSDictionary*)data{
    self = [super init];
    
    if(self){
        _critic = [data objectForKey:@"critic"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        _date = [[NSDate alloc] init];
        _date = [dateFormatter dateFromString:[data objectForKey:@"date"]];
                 
        _freshness = [data objectForKey:@"freshness"];
        _publication = [data objectForKey:@"publication"];
        _quote = [data objectForKey:@"quote"];
        _link = [NSURL URLWithString:[[data objectForKey:@"links"] objectForKey:@"review"]];

    }
    
    return self;
}
@end
