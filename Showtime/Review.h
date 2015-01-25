//
//  Review.h
//  Showtime
//
//  Created by Faiz Shukri on 1/23/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject <NSCoding>

-(id)initWithData:(NSDictionary*)data;
@property NSString *critic;
@property NSDate *date;
@property NSString *freshness;
@property NSString *publication;
@property NSString *quote;
@property NSURL *link;

@end
