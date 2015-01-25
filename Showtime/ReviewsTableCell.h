//
//  ReviewsTableCell.h
//  Showtime
//
//  Created by QAini on 1/24/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *critwriter;
@property IBOutlet UILabel *website;
@property IBOutlet UILabel *date;
@property IBOutlet UILabel *rating;
@property IBOutlet UILabel *review;


@end
