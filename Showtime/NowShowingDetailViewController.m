//
//  NowShowingDetailViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/19/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "NowShowingDetailViewController.h"
#import "ReviewsViewController.h"
#import "APIHelper.h"

@interface NowShowingDetailViewController ()

@end

@implementation NowShowingDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self tabBar:self.tabBar didSelectItem:[self.tabBar.items firstObject]];
    
    
    // Do any additional setup after loading the view.
    _movie = [APIHelper getMovieInfoById:_movie.movieId];
    
    [_thumb setImage:_movie.thumbnail];
    [_titleLabel setText:_movie.title];
    [_genresLabel setText:[_movie.genres componentsJoinedByString:@" / "]];
    [_pgAndRating setText:[NSString stringWithFormat:@"%@ / %@", _movie.mpaa_rating, _movie.ratings]];
    [_synopsisText setText:_movie.synopsis];

    
    CGSize maximumLabelSize = CGSizeMake(320, FLT_MAX);
    CGRect textRect = [_synopsisText.text boundingRectWithSize:maximumLabelSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont italicSystemFontOfSize:14.0]}
                                         context:nil];
    
    CGSize expectedLabelSize = textRect.size;
    long contentHeight = _synopsisText.frame.origin.y + expectedLabelSize.height + 110;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, contentHeight);
    
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    switch (item.tag)
    {
        case 2:
            NSLog(@"Favor This!");
            break;
        case 3:
            NSLog(@"Read Reviews");
            break;
        case 4:
            NSLog(@"Share with your friends");
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
