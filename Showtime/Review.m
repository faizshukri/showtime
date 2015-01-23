//
//  Review.m
//  Showtime
//
//  Created by Faiz Shukri on 1/23/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Review.h"

@implementation Review

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
