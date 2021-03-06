//
//  NowShowingDetailViewController.h
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

typedef NS_ENUM(NSInteger, ButtonType){
    FAVOURITE = 1,
    REVIEW = 2,
    SHARE = 3
};

@interface MovieDetailViewController : UIViewController

@property Movie *movie;
@property NSArray* similarMovies;

@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *pgAndRating;

@property (weak, nonatomic) IBOutlet UILabel *synopsisText;
@property (weak, nonatomic) IBOutlet UILabel *castsText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;

-(IBAction)btnPressed:(id)sender;

@end
