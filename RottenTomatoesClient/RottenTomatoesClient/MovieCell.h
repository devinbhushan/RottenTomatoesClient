//
//  MovieCell.h
//  RottenTomatoesClient
//
//  Created by Devin Bhushan on 9/15/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property(strong, nonatomic) IBOutlet UIImageView *moviePosterView;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property(weak, nonatomic) IBOutlet UILabel *durationLabel;
@property(weak, nonatomic) IBOutlet UILabel *criticRatingLabel;

@end
