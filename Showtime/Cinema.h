//
//  Cinema.h
//  Showtime
//
//  Created by Faiz Shukri on 1/22/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Cinema : NSObject

@property NSString *title;
@property NSString *address;
@property CLLocationCoordinate2D coordinate;
@property NSURL *url;

-(id)initWithMKMapItem:(MKMapItem*)mapItem;

@end
