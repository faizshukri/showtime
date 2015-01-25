//
//  Archiver.m
//  Showtime
//
//  Created by Faiz Shukri on 1/24/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Archiver.h"
#import "Movie.h"

@implementation Archiver

+(NSString *)archivePath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"movies.archive"];
}

+(BOOL)archive:(Movie*)movie {
    
    // Initialize favourite movies
    NSMutableDictionary *movies = [[NSMutableDictionary alloc] initWithDictionary:[Archiver unarchive]];
    
    NSString *movieKey = [NSString stringWithFormat:@"%d", movie.movieId];
    
    // Check if object archive already have the movie
    if(![movies objectForKey:movieKey]){
        
        // Add new movie only of it not exist yet
        [movies setObject:movie forKey:movieKey];
    }
    
    // Store as object archive
    return [NSKeyedArchiver archiveRootObject:movies toFile:[Archiver archivePath]];
}

+(NSDictionary*)unarchive {
    NSDictionary *movies = [NSKeyedUnarchiver unarchiveObjectWithFile:[Archiver archivePath]];
    if(!movies){
        // File not exist. We create new empty array
        movies = [[NSDictionary alloc] init];
    }
    return movies;
}

@end
