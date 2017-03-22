//
//  MoviesListVC.h
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 22/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviesListCell.h"
#import "MoviesDetailsModel.h"

@interface MoviesListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) NSMutableArray *moviesList;

@end
