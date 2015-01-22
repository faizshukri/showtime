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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbCell" forIndexPath:indexPath];
    
    // Configure the cell
    Movie *movie = [moviesArray objectAtIndex:[indexPath row]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:movie.thumbnail];
    [cell setBackgroundView:imgView];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)){
        _currentPage++;
        [moviesArray addObjectsFromArray:[movies getMoviesAtPage:_currentPage]];
        [self.collectionView reloadData];
    }
}
// Show NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
