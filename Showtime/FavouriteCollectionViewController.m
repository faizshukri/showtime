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

// View for each cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThumbCell" forIndexPath:indexPath];
    
    // Configure the cell
    Movie *movie = [_movies objectAtIndex:[indexPath row]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:movie.thumbnail];
    [cell setBackgroundView:imgView];
    
    return cell;
}

// Show NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// Handle clear all button pressed
- (IBAction)clearPressed:(id)sender {
    
    // Show confirmation box
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure to delete your favourite movie list?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    // If user confirm to remove, then only we proceed
    if(buttonIndex == 1){
        [Archiver removeAll];
        _movies = @[];
        [self.collectionView reloadData];
    }
}


@end
