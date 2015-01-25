//
//  FavouriteCollectionViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/25/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "FavouriteCollectionViewController.h"
#import "MovieDetailViewController.h"
#import "Archiver.h"
#import "Movie.h"

@interface FavouriteCollectionViewController ()

@end

@implementation FavouriteCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    _movies = [[Archiver unarchive] allValues];
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
    [showDetail setMovie:[_movies objectAtIndex:indexPath.row]];
     
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbCell" forIndexPath:indexPath];
    
    // Configure the cell
    
    // Configure the cell
    Movie *movie = [_movies objectAtIndex:[indexPath row]];
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

// Show NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)clearPressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure to delete your favourite movie list?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [Archiver removeAll];
        _movies = @[];
        [self.collectionView reloadData];
    }
}


@end
