//
//  MovieDetailsViewController.m
//  RottenTomatoesClient
//
//  Created by Devin Bhushan on 9/15/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MovieDetailsViewController ()

@property(weak, nonatomic) IBOutlet UIImageView *backgroundMoviePoster;
@property(weak, nonatomic) IBOutlet UILabel *criticsRatingLabel;
@property(weak, nonatomic) IBOutlet UILabel *titleAndYearLabel;
@property(weak, nonatomic) IBOutlet UILabel *audienceRatingLabel;
@property(weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.backgroundMoviePoster.alpha = 0.0;
  [UIView animateWithDuration:2.5f
                   animations:^{
                     self.backgroundMoviePoster.alpha = 1.0;
                   }];
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [self setViewValues];
  [MBProgressHUD hideHUDForView:self.view animated:YES];
  // Do any additional setup after loading the view.
}

- (void)setViewValues {
  NSDictionary *ratings = self.movieData[@"ratings"];

  self.criticsRatingLabel.text =
      [NSString stringWithFormat:@"%@%% %@", ratings[@"critics_score"],
                                 ratings[@"critics_rating"]];
  self.audienceRatingLabel.text =
      [NSString stringWithFormat:@"%@%% %@", ratings[@"audience_score"],
                                 ratings[@"audience_rating"]];
  self.titleAndYearLabel.text =
      [NSString stringWithFormat:@"%@ (%@)", self.movieData[@"title"],
                                 self.movieData[@"year"]];
  self.synopsisLabel.text =
      [NSString stringWithFormat:@"%@", self.movieData[@"synopsis"]];

  NSURL *imageURL =
      [NSURL URLWithString:self.movieData[@"posters"][@"original"]];
  [self.backgroundMoviePoster setImageWithURL:imageURL];
  self.title = self.movieData[@"title"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
