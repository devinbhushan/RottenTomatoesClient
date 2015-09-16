//
//  MoviesViewController.m
//  RottenTomatoesClient
//
//  Created by Devin Bhushan on 9/15/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *boxOfficeMovies;
@property(weak, nonatomic) IBOutlet UITableView *movieTableView;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.movieTableView.delegate = self;
  self.movieTableView.dataSource = self;

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
        NSDictionary *movieJson =
            [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.boxOfficeMovies = movieJson[@"movies"];
        //        NSLog(@"Got movies: %@", self.boxOfficeMovies);
        [self.movieTableView reloadData];
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
  NSLog(@"Movie data: %@", movieData);

  movieCell.nameLabel.text = [NSString
      stringWithFormat:@"%@ (%@)", movieData[@"title"], movieData[@"year"]];
  movieCell.ratingLabel.text = movieData[@"mpaa_rating"];
  movieCell.durationLabel.text =
      [NSString stringWithFormat:@"%@ mins", movieData[@"runtime"]];
  movieCell.criticRatingLabel.text = [NSString
      stringWithFormat:@"%@", movieData[@"ratings"][@"critics_score"]];

  NSURL *imageURL = [NSURL URLWithString:movieData[@"posters"][@"original"]];
  NSLog(@"image url: %@", imageURL);
  NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
  NSLog(@"image data: %@", imageData);
  UIImage *image = [[UIImage alloc] initWithData:imageData];

  movieCell.moviePosterView = nil;
  [movieCell.moviePosterView setImage:image];

  return movieCell;
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
