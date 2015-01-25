//
//  ReviewsTableController.h
//  Showtime
//
//  Created by QAini on 1/23/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "Review.h"

@interface ReviewsTableController : UITableViewController

@property Movie *movie;
@property Review *review;


@property NSArray *critic;
@property NSArray *web;
@property NSArray *reviewDate;
@property NSArray *freshness;
@property NSArray *quote;


@end
