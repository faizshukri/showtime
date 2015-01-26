//
//  CinemapPopoverViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/23/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "CinemapPopoverViewController.h"

@interface CinemapPopoverViewController ()

@end

@implementation CinemapPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [_nameLabel setText:_cinema.title];
    
    [_addressLabel setText:_cinema.address];
    [_addressLabel setTag:ADDRESS];
    
    [_urlLabel setText:[_cinema.url absoluteString]];
    [_urlLabel setTag:URL];
    
    // Add tap gesture for address and url to open using related application
    NSArray *linkableLabels = @[_addressLabel, _urlLabel];
    
    // Apply tap gesture for both addressLabel and urlLabel
    for (UILabel* label in linkableLabels) {
        
        UITapGestureRecognizer *gestureLink = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLink:)];
        gestureLink.numberOfTouchesRequired = 1;
        gestureLink.numberOfTapsRequired = 1;
        
        [label addGestureRecognizer:gestureLink];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

// Handle when user click a link (using gesturerecognizer
-(void)openLink:(id)sender{
    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
    
    id hitLabel = [self.view hitTest:[rec locationInView:self.view] withEvent:UIEventTypeTouches];
    
    if ([hitLabel isKindOfClass:[UILabel class]]) {
        
        // If the link is url, we open with browser
        if(rec.view.tag == URL){
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((UILabel *)hitLabel).text]];
        
        // Else if the link is address, we open using Apple Map
        } else if(rec.view.tag == ADDRESS){
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:_cinema.placemark];
            [mapItem setName:_cinema.title];
            [mapItem openInMapsWithLaunchOptions:nil];
        }
        
    }
}

@end
