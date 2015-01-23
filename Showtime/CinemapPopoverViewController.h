//
//  CinemapPopoverViewController.h
//  Showtime
//
//  Created by Faiz Shukri on 1/23/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"

@interface CinemapPopoverViewController : UITableViewController

@property Cinema *cinema;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end
