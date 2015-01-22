//
//  UpcomingCollectionViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/21/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "UpcomingCollectionViewController.h"
#import "NowShowingDetailViewController.h"
#import "Movie.h"

@interface UpcomingCollectionViewController ()

@end

@implementation UpcomingCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    _currentPage = 1;
    _pageLimit = 15;
    
    _movies = [[Movies alloc] initWithLimit:_pageLimit andPage:_currentPage movieType:MOVIE_UPCOMING];
    _movieInSection = [[NSMutableDictionary alloc] initWithDictionary:[_movies getMoviesInSections]];
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
    
    NowShowingDetailViewController *showDetail = [segue destinationViewController];
    [showDetail setMovie:[[[_movieInSection allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _movieInSection.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[_movieInSection allValues] objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbCell" forIndexPath:indexPath];
    
    // Configure the cell
    Movie *movie = [[[_movieInSection allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:movie.thumbnail];
    [cell setBackgroundView:imgView];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *sectionHeader = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
    
    // Draw section header only once. If detecting that it already has title, just ignore
    if([[sectionHeader subviews] count] == 0){
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 40)];
        [headerLabel setText:[[_movieInSection allKeys] objectAtIndex:indexPath.section]];
        [sectionHeader addSubview:headerLabel];
    }
    return sectionHeader;
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
        NSDictionary *movieSectionAtPage = [_movies getMoviesInSectionsAtPage:_currentPage];
        for(NSString *key in [movieSectionAtPage allKeys]){
            if( [[_movieInSection allKeys] containsObject:key] ){
                [(NSMutableArray*)[_movieInSection objectForKey:key] addObjectsFromArray:[movieSectionAtPage objectForKey:key]];
            } else {
                [(NSMutableDictionary*)_movieInSection setObject:[movieSectionAtPage objectForKey:key] forKey:key];
            }
        }
        [self.collectionView reloadData];
    }
}

// Show NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
