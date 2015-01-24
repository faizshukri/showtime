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
    
    
    
    NSArray *reviews = _movie.reviews;
    
    _critic = [reviews valueForKey:@"critic"];
    _reviewDate = [reviews valueForKey:@"date"];
    _freshness = [reviews valueForKey:@"freshness"];
    _web = [reviews valueForKey:@"publication"];
    _quote = [reviews valueForKey:@"quote"];
    
    
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
    return self.critic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"reviewCell";
    
    ReviewsTableCell *cell = (ReviewsTableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.critwriter.text = [self.critic objectAtIndex:indexPath.row];
    // cell.date.text = [self.reviewDate objectAtIndex:indexPath.row ];
    
    cell.website.text = [self.web objectAtIndex:indexPath.row];
    
    cell.rating.text = [self.freshness objectAtIndex:indexPath.row];
    
    cell.review.text = [self.quote objectAtIndex:indexPath.row];
    cell.review.lineBreakMode = NSLineBreakByWordWrapping;
    cell.review.numberOfLines = 0;
    
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