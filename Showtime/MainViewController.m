//
//  MainViewController.m
//  Showtime
//
//  Created by Faiz Shukri on 1/8/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"stimebg.png"] drawInRect:self.view.bounds];
    UIImage *bground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:bground];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    _nowShowing.font = [UIFont fontWithName:@"HarlowSolidItalic.ttf" size:21];
    _comingSoon.font = [UIFont fontWithName:@"HarlowSolidItalic.ttf" size:21];
    _cineMap.font = [UIFont fontWithName:@"HarlowSolidItalic.ttf" size:21];
    _myFav.font = [UIFont fontWithName:@"HarlowSolidItalic.ttf" size:21];

}


// Hide NavBar in Root View
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
