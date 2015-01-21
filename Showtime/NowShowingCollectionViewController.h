//
//  NowShowingCollectionViewController.h
//  Showtime
//
//  Created by Faiz Shukri on 1/17/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movies.h"

@interface NowShowingCollectionViewController : UICollectionViewController <UIScrollViewDelegate>{
    int _currentPage;
    int _pageLimit;
}

@property Movies *movies;
@property NSMutableArray *moviesArray;

@end
