//
//  APIHelper.h
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIHelper : NSObject

+(NSString*)apikey;
+(NSArray*)getShowingMoviesWithLimit:(int)limit atPage:(int)page filterLocation:(NSString*)countryCode;
+(NSArray*)getMovieInfoById:(int)movieId;
+(UIImage *)getThumbWithURL:(NSString*)url;

@end
