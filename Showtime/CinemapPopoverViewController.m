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

-(void)openLink:(id)sender{
    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
    
    id hitLabel = [self.view hitTest:[rec locationInView:self.view] withEvent:UIEventTypeTouches];
    
    if ([hitLabel isKindOfClass:[UILabel class]]) {
        
        if(rec.view.tag == URL){
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((UILabel *)hitLabel).text]];
        } else if(rec.view.tag == ADDRESS){
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:_cinema.placemark];
            [mapItem setName:_cinema.title];
            [mapItem openInMapsWithLaunchOptions:nil];
        }
        
    }
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
