//
//  Archiver.m
//  Showtime
//
//  Created by Faiz Shukri on 1/24/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Archiver.h"

@implementation Archiver

+(NSString *)archivePath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"movies.archive"];
}

+(BOOL)archive:(id)movie {
    
    // Initialize favourite movies
    NSMutableArray *movies = [[NSMutableArray alloc] initWithArray:[Archiver unarchive]];
    
    // Add object to the array
    [movies addObject:movie];
    
    // Store as object archive
    return [NSKeyedArchiver archiveRootObject:movies toFile:[Archiver archivePath]];
}

+(NSArray*)unarchive {
    NSArray *movies = [NSKeyedUnarchiver unarchiveObjectWithFile:[Archiver archivePath]];
    if(!movies){
        // File not exist. We create new empty array
        movies = [[NSArray alloc] init];
    }
    return movies;
}

@end
