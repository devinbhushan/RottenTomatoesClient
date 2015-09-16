//
//  MovieCell.m
//  RottenTomatoesClient
//
//  Created by Devin Bhushan on 9/15/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import "MovieCell.h"
#define UIColorFromRGB(rgbValue)                                               \
  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0         \
                  green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0            \
                   blue:((float)(rgbValue & 0xFF)) / 255.0                     \
                  alpha:1.0]

@implementation MovieCell

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  if (selected) {
    self.backgroundColor = UIColorFromRGB(0xD3D3D3);
    //    self.alpha = 0.6;
  }
  // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  if (highlighted) {
    self.backgroundColor = UIColorFromRGB(0x067AB5);
  } else {
    self.backgroundColor = [[UIColor alloc] initWithRed:1
                                                  green:0.87396507359999998
                                                   blue:0.66938323749999995
                                                  alpha:1.0];
  }
}

@end
