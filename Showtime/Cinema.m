//
//  Cinema.m
//  Showtime
//
//  Created by Faiz Shukri on 1/22/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "Cinema.h"

@implementation Cinema

-(id)initWithMKMapItem:(MKMapItem*)mapItem{
    
    self = [super init];
    
    if(self){
        _title = mapItem.name;
        _coordinate = mapItem.placemark.coordinate;
        _placemark = mapItem.placemark;
        
        NSDictionary *addressDictionary = mapItem.placemark.addressDictionary;
        NSString *formattedAddress = [[addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        _address = formattedAddress;
        _url = mapItem.url;
    }
    
    return self;
}

@end
