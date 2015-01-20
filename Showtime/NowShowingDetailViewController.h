//
//  NowShowingDetailViewController.h
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface NowShowingDetailViewController : UIViewController

@property Movie *movie;
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *pgAndRating;

@property (weak, nonatomic) IBOutlet UITabBarItem *tabBar1;


@end
