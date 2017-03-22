//
//  MoviesListVC.m
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 22/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import "MoviesListVC.h"

@interface MoviesListVC (){
    NSMutableArray *moviesListArray;
}
@property (weak, nonatomic) IBOutlet UITableView *moviesListTV;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *backButtonView;

@end

@implementation MoviesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.moviesListTV.delegate = self;
    self.moviesListTV.dataSource = self;
    moviesListArray = [[NSMutableArray alloc] init];
    moviesListArray = self.moviesList;
    self.headerView.layer.borderWidth = 1.0;
    self.headerView.layer.borderColor = [UIColor grayColor].CGColor;
    
}

#pragma mark - UITableVie Data Source & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.moviesListTV)
        return [moviesListArray count];
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (tableView == self.moviesListTV) {
        NSString *MyIdentifier = @"moviesListCell";
        MoviesListCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
        
        MoviesDetailsModel *moviesDetailsModel = moviesListArray[indexPath.row];
        
        if(![moviesDetailsModel.title isEqual:[NSNull null]]){
            cell.moviesNameLabel.text = [NSString stringWithFormat:@"%@", moviesDetailsModel.title];
        }
        
        if(![moviesDetailsModel.genre isEqual:[NSNull null]]){
            cell.generLabel.text = [NSString stringWithFormat:@"%@", moviesDetailsModel.genre];
        }
        
        if(![moviesDetailsModel.plot isEqual:[NSNull null]]){
            cell.plotTextView.text = [NSString stringWithFormat:@"%@", moviesDetailsModel.plot];
        }
        
        if(![moviesDetailsModel.released isEqual:[NSNull null]]){
            cell.releaseDateLabel.text = [NSString stringWithFormat:@"%@", moviesDetailsModel.released];
        }
        
        if(![moviesDetailsModel.imdbRating isEqual:[NSNull null]]){
            cell.ratingLabel.text = [NSString stringWithFormat:@"%@", moviesDetailsModel.imdbRating];
        }
        
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"%@", moviesDetailsModel.poster]]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.moviePicIV.image = [UIImage imageWithData: data];
            });
        });
        
        return cell;
    }
    
    return cell;
}

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
