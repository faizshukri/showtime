//
//  Archiver.h
//  Showtime
//
//  Created by Faiz Shukri on 1/24/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface Archiver : NSObject

+(NSString*) archivePath;
+(BOOL)archive:(Movie*)movie;
+(NSDictionary*)unarchive;

+(void)removeSelection:(Movie*)movie;
+(void)removeAll;

@end
