//
//  NowShowingDetailViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "NowShowingDetailViewController.h"
#import "APIHelper.h"
#import "Movies.h"

@interface NowShowingDetailViewController ()

@end

@implementation NowShowingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _movie = [APIHelper getMovieInfoById:_movie.movieId];
    _similarMovies = [[[Movies alloc] init] getSimilarMoviesByID:_movie.movieId];
    
    [_thumb setImage:_movie.thumbnail];
    [_titleLabel setText:_movie.title];
    [_genresLabel setText:[_movie.genres componentsJoinedByString:@" / "]];
    [_pgAndRating setText:[NSString stringWithFormat:@"%@ / %@", _movie.mpaa_rating, _movie.ratings]];
    [_synopsisText setText:_movie.synopsis];
    [_castsText setText:[_movie.cast componentsJoinedByString:@"\n"]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIView *similarPanel = [[UIView alloc] init];
    int imgHeight = 133;
    
    for(int similar = 0; similar < _similarMovies.count; similar++){
        Movie *movie = [_similarMovies objectAtIndex:similar];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:movie.thumbnail];
        [imageView setFrame:CGRectMake(115*similar, 0, 100, imgHeight)];
        [similarPanel addSubview:imageView];
    }
    
    UIView *lastObj = [_scrollView viewWithTag:1];
    
    if(_similarMovies.count <= 0){
        imgHeight = 0;
    }
    
    [similarPanel setFrame:CGRectMake(20, lastObj.frame.origin.y+30, similarPanel.frame.size.width, imgHeight)];
    [_scrollView addSubview:similarPanel];
    
    long contentHeight = similarPanel.frame.origin.y + similarPanel.frame.size.height + 70;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, contentHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
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
