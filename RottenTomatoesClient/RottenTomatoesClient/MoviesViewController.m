//
//  MoviesViewController.m
//  RottenTomatoesClient
//
//  Created by Devin Bhushan on 9/15/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieDetailsViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *boxOfficeMovies;
@property(weak, nonatomic) IBOutlet UITableView *movieTableView;
@property(nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.movieTableView.delegate = self;
  self.movieTableView.dataSource = self;

  [self.refreshControl addTarget:self
                          action:@selector(onRefresh:)
                forControlEvents:UIControlEventValueChanged];
  [self.movieTableView addSubview:self.refreshControl];

  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [self fetchMovies];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)fetchMovies {
  NSURL *boxOfficeUrl =
      [NSURL URLWithString:@"https://gist.githubusercontent.com/timothy1ee/"
             @"d1778ca5b944ed974db0/raw/"
             @"489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/" @"gistfile1.json"];
  NSURLSession *session = [NSURLSession sharedSession];
  [[session
        dataTaskWithURL:boxOfficeUrl
      completionHandler:^(NSData *data, NSURLResponse *response,
                          NSError *error) {
        if (error) {
          UIAlertView *alert = [[UIAlertView alloc]
                  initWithTitle:@"Failed to load!"
                        message:@"Connection to Rotten Tomatoes Failed"
                       delegate:self
              cancelButtonTitle:@"Cancel"
              otherButtonTitles:nil];
          [alert show];
        }

        NSDictionary *movieJson =
            [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.boxOfficeMovies = movieJson[@"movies"];
        [self.movieTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
      }] resume];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.boxOfficeMovies count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MovieCell *movieCell =
      [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.movieCell"];

  NSDictionary *movieData = self.boxOfficeMovies[indexPath.section];

  movieCell.nameLabel.text = [NSString
      stringWithFormat:@"%@ (%@)", movieData[@"title"], movieData[@"year"]];
  movieCell.ratingLabel.text = movieData[@"mpaa_rating"];
  movieCell.durationLabel.text =
      [NSString stringWithFormat:@"%@ mins", movieData[@"runtime"]];
  movieCell.criticRatingLabel.text = [NSString
      stringWithFormat:@"%@", movieData[@"ratings"][@"critics_score"]];

  NSURL *imageURL = [NSURL URLWithString:movieData[@"posters"][@"original"]];

  movieCell.moviePosterView.alpha = 0.0;
  [UIView animateWithDuration:2.5f
                   animations:^{
                     movieCell.moviePosterView.alpha = 1.0;
                   }];

  [movieCell.moviePosterView setImageWithURL:imageURL];

  return movieCell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //     Get the new view controller using [segue destinationViewController].
  //     Pass the selected object to the new view controller.
  MovieCell *cell = (MovieCell *)sender;
  NSDictionary *movieData = [self.boxOfficeMovies
      objectAtIndex:(int)[self.movieTableView indexPathForCell:cell].section];
  MovieDetailsViewController *vc = [segue destinationViewController];
  vc.movieData = movieData;
}

- (void)onRefresh {
  [self fetchMovies];
  [self.refreshControl endRefreshing];
}

@end
