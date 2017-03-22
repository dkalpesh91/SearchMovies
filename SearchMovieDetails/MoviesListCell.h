//
//  MoviesListCell.h
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 22/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moviesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *generLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *plotTextView;
@property (weak, nonatomic) IBOutlet UIImageView *moviePicIV;
@property (weak, nonatomic) IBOutlet UIButton *viewMoreButton;

@end
