//
//  Thumb.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Thumb.h"

@implementation Thumb

-(id) initWithUrl:(NSString*) url{
    
    url = [url stringByReplacingOccurrencesOfString:@"tmb.jpg" withString:@"pro.jpg"];
    NSURL *imageString = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageString];
    
    self = [super initWithData:imageData];
    return self;
}

@end
