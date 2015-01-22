//
//  ReviewsViewController.m
//  Showtime
//
//  Created by QAini on 1/21/15.
//  Copyright (c) 2015 Faiz Shukri. All rights reserved.
//

#import "ReviewsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ReviewsViewController ()

@end

@implementation ReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:YES];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"stimebg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:NO animated:YES];
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
