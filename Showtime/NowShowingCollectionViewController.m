//
//  NowShowingCollectionViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/17/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "NowShowingCollectionViewController.h"
#import "MovieDetailViewController.h"
#import "Movies.h"

@interface NowShowingCollectionViewController ()

@end

@implementation NowShowingCollectionViewController

@synthesize movies, moviesArray;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Draw background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"stimebg.png"] drawInRect:self.view.bounds];
    UIImage *bground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:bground];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    _pageLimit = 15;
    _currentPage = 1;
    
    // Initialize movies
    movies = [[Movies alloc] initWithLimit:_pageLimit andPage:_currentPage movieType:MOVIE_SHOWING];
    moviesArray = [[NSMutableArray alloc] initWithArray:[movies getMovies]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Prepare data to be pass into MovieDetail Controller
    UICollectionViewCell *cell = (UICollectionViewCell*) sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    MovieDetailViewController *showDetail = [segue destinationViewController];
    [showDetail setMovie:[moviesArray objectAtIndex:indexPath.row]];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return moviesArray.count;
}

// View for each cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbCell" forIndexPath:indexPath];
    
    // Configure the cell
    Movie *movie = [moviesArray objectAtIndex:[indexPath row]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:movie.thumbnail];
    [cell setBackgroundView:imgView];
    
    return cell;
}

// We create infinite scrolling. After finish drag, get the next movie page
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    // Check if user finish drag at bottom of movies list
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)){
        
        // Increase current page flag
        _currentPage++;
        
        // Get movies list at the new page
        [moviesArray addObjectsFromArray:[movies getMoviesAtPage:_currentPage]];
        
        // Reload the collection data
        [self.collectionView reloadData];
    }
}
// Show NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
