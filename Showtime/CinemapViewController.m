//
//  CinemapViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/22/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "CinemapViewController.h"
#import "CinemapPopoverViewController.h"
#import "Cinema.h"
#import "WYPopoverController.h"

@interface CinemapViewController () <WYPopoverControllerDelegate>{
    WYPopoverController* popoverController;
}

@end

@implementation CinemapViewController

@synthesize locationManager, mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // create a location manager if we don't have one"
    locationManager = [[CLLocationManager alloc]init];
    
    // this object will act as the delegate"
    locationManager.delegate = self;
    
    [locationManager requestWhenInUseAuthorization];
    
    // start the service"
    [locationManager startUpdatingLocation];
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.location.coordinate, 5000, 5000);
    
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    [mapView setRegion:region animated:YES];
    
    // Add user location tracking button, so user can easily go to their current location
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Search place in the map with any keyword
-(void)searchFor:(NSString*)text {
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = text;
    request.region = mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if(response.mapItems.count == 0){
            NSLog(@"No matches");
        } else {
            NSMutableArray *items = [[NSMutableArray alloc] init];
            
            for(MKMapItem *item in response.mapItems){
                Cinema *cinema = [[Cinema alloc] initWithMKMapItem:item];
                [items addObject:cinema];
            }
            [mapView removeAnnotations:[mapView annotations]];
            [mapView addAnnotations:items];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)mapView:(MKMapView *)mkMapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    mapView.centerCoordinate = userLocation.location.coordinate;
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self searchFor:@"cinema"];
}

// Show NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// Create custom annotation view
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    // If the annotation is for user location, we use the default one
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"Annotation";
    // like we saw with table cells - see if there is an annotation view that we can reuse
    // if there is, use it
    // of not, make one
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    } else {
        annotationView.annotation = annotation;
    }
    
    // We will show custom callout instead
    annotationView.canShowCallout = NO;
    annotationView.image=[UIImage imageNamed:@"marker.png"]; // custom marker
    
    return annotationView;
}

// Create custom popover callout when annotation clicked
-(void)mapView:(MKMapView *)MKMapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    // If the annotation is the user location, we user the default one
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        return;
    }
    
    [mapView deselectAnnotation:view.annotation animated:YES];
    
    Cinema *cinema = (Cinema*)view.annotation;
    //    MarkerPopoverViewController *vc = [[MarkerPopoverViewController alloc] initWithCinema:cinema];
    CinemapPopoverViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"cinemaPopover"];
    [vc setCinema:cinema];
    
    
    // Here we use 3rd party library (WYPopoverController) to draw the popover, since UIPopoverController provided by Cocoa can only be used in iPad, and not work for iPhone.
    popoverController = [[WYPopoverController alloc] initWithContentViewController:vc];
    
    // Perform layout before drawing to correct the return contentSize
    [vc.tableView layoutIfNeeded];
    popoverController.popoverContentSize = vc.tableView.contentSize;
    popoverController.delegate = self;
    
    // Show the popover
    [popoverController presentPopoverFromRect:view.frame inView:view.superview permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

@end
