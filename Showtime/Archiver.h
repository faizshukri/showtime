//
//  Archiver.h
//  Showtime
//
//  Created by Faiz Shukri on 1/24/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Archiver : NSObject

+(NSString*) archivePath;
+(BOOL)archive:(id)movie;
+(NSArray*)unarchive;

@end
