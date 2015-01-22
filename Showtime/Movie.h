//
//  Movie.h
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property int movieId;
@property NSString *title;
@property UIImage *thumbnail;
@property NSString *synopsis;
@property NSArray *genres;
@property NSString *mpaa_rating;
@property NSString *ratings;
@property NSArray *cast;
@property NSDate *release_date;
@property NSURL *pageURL;

-(id) initWithData:(NSDictionary*)data;

@end
