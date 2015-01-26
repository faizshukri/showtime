//
//  NowShowingDetailViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "ReviewsTableController.h"
#import "APIHelper.h"
#import "Movies.h"
#import "Archiver.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setToolbarHidden: NO];
    
    // Set background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"stimebg.png"] drawInRect:self.view.bounds];
    UIImage *bground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:bground];
    
    // Initialize movie with the movie id provided by previous segue
    _movie = [APIHelper getMovieInfoById:_movie.movieId];
    
    // Get the similar movie
    _similarMovies = [[[Movies alloc] init] getSimilarMoviesByID:_movie.movieId];
    
    // Set the movie view property text
    [_thumb setImage:_movie.thumbnail];
    [_titleLabel setText:_movie.title];
    [_genresLabel setText:[_movie.genres componentsJoinedByString:@" / "]];
    [_pgAndRating setText:[NSString stringWithFormat:@"%@ / %@", _movie.mpaa_rating, _movie.ratings]];
    [_synopsisText setText:_movie.synopsis];
    [_castsText setText:[_movie.cast componentsJoinedByString:@"\n"]];
    
    // Set some style for thumbnail container
    [_thumb.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_thumb.layer setBorderWidth: 3.0];
    
    // Create date in some format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, yyyy"];
    [_releaseDate setText:[dateFormatter stringFromDate:_movie.release_date]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Prepare panel for 3 similar movie thumbnail
    UIView *similarPanel = [[UIView alloc] init];
    int imgHeight = 133, imgWidth = 100;
    
    // Iterate over 3 similar movies
    for(int similar = 0; similar < _similarMovies.count; similar++){
        Movie *movie = [_similarMovies objectAtIndex:similar];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:movie.thumbnail];
        [imageView setFrame:CGRectMake(115*similar, 0, imgWidth, imgHeight)];
        [similarPanel addSubview:imageView];
    }
    
    UIView *lastObj = [_scrollView viewWithTag:1];
    
    // If there's no similar movie in API, we remove the space
    if(_similarMovies.count <= 0){
        imgHeight = 0;
    }
    
    // Add the panel to the frame
    [similarPanel setFrame:CGRectMake(20, lastObj.frame.origin.y+30, similarPanel.frame.size.width, imgHeight)];
    [_scrollView addSubview:similarPanel];
    
    // Set the content size, so the scroll by work properly
    long contentHeight = similarPanel.frame.origin.y + similarPanel.frame.size.height + 20;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, contentHeight);
    
}

// Handle button pressed for favourite and share button
-(IBAction)btnPressed:(UIBarButtonItem *)sender{
    
    // If favourite button pressed
    if(sender.tag == FAVOURITE){
        
        // If we successfully archive the movie, show the modal dialog to user
        if([Archiver archive:_movie]){
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"This movie has been add to your favourite list"
                                                           delegate:self cancelButtonTitle:@"Okay, thanks"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }
    
    // If share button pressed
    }else if(sender.tag == SHARE){
        
        // Prepare data
        NSString *apptext = @"Showtime! wants you to check this out! - ";
        NSString *movieTitle = _movie.title;
        NSURL *website = _movie.pageURL;
        
        NSArray *objectsToShare = @[apptext, movieTitle, website];
        
        UIActivityViewController *shareType = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        
        NSArray *excludeType = @[UIActivityTypeAirDrop,
                                       UIActivityTypePrint,
                                       UIActivityTypeAssignToContact,
                                       UIActivityTypeSaveToCameraRoll,
                                       UIActivityTypeAddToReadingList,
                                       UIActivityTypePostToFlickr,
                                       UIActivityTypePostToVimeo];
        
        shareType.excludedActivityTypes = excludeType;
        
        [self presentViewController:shareType animated:YES completion:nil];
    }
    
}


- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Prepare data for reviews controller
    ReviewsTableController *vc = [segue destinationViewController];
    [vc setReviews:_movie.reviews];
}


@end
