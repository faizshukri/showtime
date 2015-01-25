//
//  FavouriteCollectionViewController.h
//  Showtime
//
//  Created by Faiz Shukri on 1/25/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavouriteCollectionViewController : UICollectionViewController <UIAlertViewDelegate>

@property NSArray *movies;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *clear;

- (IBAction)clearPressed:(id)sender;

@end
