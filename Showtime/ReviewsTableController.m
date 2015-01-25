//
//  ReviewsTableController.m
//  Showtime
//
//  Created by QAini on 1/23/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "ReviewsTableController.h"
#import "ReviewsTableCell.h"

@interface ReviewsTableController()

@end



@implementation ReviewsTableController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Set the bacgkround image for view
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"stimebg.png"] drawInRect:self.view.bounds];
    UIImage *bground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:bground];
    
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"reviewCell";
    
    ReviewsTableCell *cell = (ReviewsTableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Review *review = [_reviews objectAtIndex:indexPath.row];
    
    cell.critwriter.text = review.critic;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    
    cell.date.text = [dateFormatter stringFromDate:review.date];
    
    cell.website.text = review.publication;
    
    cell.rating.text = review.freshness;
    
    cell.review.text = review.quote;
    
    return cell;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end