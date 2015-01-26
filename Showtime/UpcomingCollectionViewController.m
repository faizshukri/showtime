//
//  UpcomingCollectionViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/21/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "UpcomingCollectionViewController.h"
#import "MovieDetailViewController.h"
#import "Movie.h"

@interface UpcomingCollectionViewController ()

@end

@implementation UpcomingCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Draw background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"stimebg.png"] drawInRect:self.view.bounds];
    UIImage *bground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:bground];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    _currentPage = 1;
    _pageLimit = 15;
    
    // Initialize movies
    _movies = [[Movies alloc] initWithLimit:_pageLimit andPage:_currentPage movieType:MOVIE_UPCOMING];
    
    // Prepare NSDictionary for section structure of movies
    _movieInSection = [[NSMutableDictionary alloc] initWithDictionary:[_movies getMoviesInSections]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Prepare data to be pass onto MovieDetail Controller
    UICollectionViewCell *cell = (UICollectionViewCell*) sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    MovieDetailViewController *showDetail = [segue destinationViewController];
    [showDetail setMovie:[[[_movieInSection allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _movieInSection.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[_movieInSection allValues] objectAtIndex:section] count];
}

// View for each cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbCell" forIndexPath:indexPath];
    
    // Configure the cell
    Movie *movie = [[[_movieInSection allValues] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:movie.thumbnail];
    [cell setBackgroundView:imgView];
    
    return cell;
}

// To draw text in the row header. Section title.
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

// We create infinite scrolling. After finish drag, get the next movie page
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    // Check if user finish drag at bottom of movies list
    if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)){
        
        // Increase current page flag
        _currentPage++;
        
        // Get movies list at the new page
        NSDictionary *movieSectionAtPage = [_movies getMoviesInSectionsAtPage:_currentPage];
        
        // For each result, we append to current movie section
        for(NSString *key in [movieSectionAtPage allKeys]){
            
            // If section is already exist, we put movie into that section
            if( [[_movieInSection allKeys] containsObject:key] ){
                [(NSMutableArray*)[_movieInSection objectForKey:key] addObjectsFromArray:[movieSectionAtPage objectForKey:key]];
                
            // if not, we create a new section
            } else {
                [(NSMutableDictionary*)_movieInSection setObject:[movieSectionAtPage objectForKey:key] forKey:key];
            }
        }
        
        // Reload the collection data
        [self.collectionView reloadData];
    }
}

// Show NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
