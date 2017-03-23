//
//  MoviesSearchVC.m
//  SearchMovieDetails
//
//  Created by ePaisa iOS Developer on 21/03/17.
//  Copyright © 2017 Kalpesh iOS Developer. All rights reserved.
//

#import "MoviesSearchVC.h"
#import "MBProgressHUD.h"
#import "MoviesDetailsModel.h"

@interface MoviesSearchVC (){
    NetworkHelper * networkHelper;
    NSMutableArray *moviesListArray;
    NSString *type;
    NSString *searchBy;
}
@property (weak, nonatomic) IBOutlet UITextField *movieNameTF;
@property (weak, nonatomic) IBOutlet UIButton *searchMoviesButton;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *serialCheckmark;
@property (weak, nonatomic) IBOutlet UIImageView *moviesCheckmark;
@property (weak, nonatomic) IBOutlet UIView *checkmarksView;
@property (weak, nonatomic) IBOutlet UIView *sepView;
@property (weak, nonatomic) IBOutlet UIView *searchByView;
@property (weak, nonatomic) IBOutlet UIView *sepView1;
@property (weak, nonatomic) IBOutlet UIImageView *searchByCheckMark;
@property (weak, nonatomic) IBOutlet UIImageView *titleByCheckMark;

@end

@implementation MoviesSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews {
    networkHelper = [[NetworkHelper alloc] init];
    networkHelper.delegate = self;
    
    moviesListArray = [[NSMutableArray alloc] init];
    
    self.headerView.layer.borderWidth = 0.5;
    self.headerView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.movieNameTF.delegate = self;
    
    self.movieNameTF.layer.borderWidth = 0.5;
    self.movieNameTF.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.searchMoviesButton.layer.borderColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1].CGColor;
    self.searchMoviesButton.layer.borderWidth = 0.5;
    self.searchMoviesButton.layer.cornerRadius = 10.0;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 35)];
    self.movieNameTF.leftView = paddingView;
    self.movieNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.moviesCheckmark.hidden = NO;
    self.serialCheckmark.hidden = YES;
    
    self.searchByCheckMark.hidden = NO;
    self.titleByCheckMark.hidden = YES;
    
    self.checkmarksView.layer.borderWidth = 0.5;
    self.checkmarksView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.sepView.layer.borderWidth = 0.25;
    self.sepView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.searchByView.layer.borderWidth = 0.5;
    self.searchByView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.sepView1.layer.borderWidth = 0.25;
    self.sepView1.layer.borderColor = [UIColor grayColor].CGColor;
    
    type = @"movie";
    searchBy = @"s";
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    moviesListArray = [[NSMutableArray alloc] init];
}

#pragma mark - getsearchMoviesList
- (IBAction)getsearchMoviesList:(UIButton *)sender {
    [self.view endEditing:YES];
    if(self.movieNameTF.text.length != 0){
    NSMutableDictionary *tempData = [[NSMutableDictionary alloc]init];
    [tempData setObject:[NSString stringWithFormat:@"%@", self.movieNameTF.text] forKey:searchBy];
    [tempData setObject:type forKey:@"type"];
    [self showLodingWithMessage:@"" withView:self.view];
    [networkHelper getMoviesListAPICall:tempData];
    }else{
        [self showErrorMessage:@"Please provide movie name!" withView:self.view withDelay:3.f];
    }
    
}



- (void)searchMoviesCallApicallSuccess:(NSMutableData *)data{
     [self hideLoadingView:self.view];
        NSError* error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
    
        NSLog(@"dictionary : %@",dictionary);
    
    
    
    
         if ([dictionary[@"Response"] boolValue]) {
             if ([searchBy  isEqual: @"s"]) {
                 NSArray *tempArray = dictionary[@"Search"];
                 for (NSDictionary *temp in tempArray) {
                     MoviesDetailsModel *moviesDetailsModel = [MoviesDetailsModel getMoviesDetailsFromDictionary:temp];
                     [moviesListArray addObject:moviesDetailsModel] ;
                 }
             }else{
                 MoviesDetailsModel *moviesDetailsModel = [MoviesDetailsModel getMoviesDetailsFromDictionary:dictionary];
                 [moviesListArray addObject:moviesDetailsModel] ;
             }
             
             [self performSegueWithIdentifier:@"showMovieList" sender:nil];
             
         }else{
             [self showErrorMessage:@"Movie not found!" withView:self.view withDelay:3.f];
         }
    
    
}

- (void)searchMoviesCallErrorCallback:(NSError *)error{
    [self hideLoadingView:self.view];
    NSLog(@"LocationsCallForBusBookingErrorCallback : %@", error.localizedDescription);
}


#pragma mark - MBProgressHUD

-(void)hideLoadingView:(UIView *)view{
    view.userInteractionEnabled = YES;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

-(MBProgressHUD *)showLodingWithMessage:(NSString *)message withView:(UIView *)view
{
    MBProgressHUD *mbHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    view.userInteractionEnabled = NO;
    mbHUD.mode = MBProgressHUDModeIndeterminate;
    mbHUD.detailsLabelText = message;
    return mbHUD;
}

-(MBProgressHUD*)showErrorMessage:(NSString *)message withView:(UIView *)view withDelay:(CGFloat)period
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES] ;
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    [hud hide:YES afterDelay:period];
    return hud;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMovieList"]) {
        
        MoviesListVC *moviesListVC = (MoviesListVC*)segue.destinationViewController;
        moviesListVC.moviesList = moviesListArray;
    }
}

#pragma mark - Textfield Delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
    
- (IBAction)byMoviesButtonAction:(UIButton *)sender {
    self.moviesCheckmark.hidden = NO;
    self.serialCheckmark.hidden = YES;
    type = @"movie";
    
}

- (IBAction)bySeriesButtonAction:(UIButton *)sender {
    self.serialCheckmark.hidden = NO;
    self.moviesCheckmark.hidden = YES;
    type = @"series";
}
- (IBAction)titleBYButtonAction:(id)sender {
    self.titleByCheckMark.hidden = NO;
    self.searchByCheckMark.hidden = YES;
    searchBy = @"t";
}
- (IBAction)searchBybuttonAction:(UIButton *)sender {
    self.searchByCheckMark.hidden = NO;
    self.titleByCheckMark.hidden = YES;
    searchBy = @"s";
}


#pragma mark - Movie Search Test Case Method
- (void)checkVC:(NSString *)text {
        NSLog(@"Movie Search VC Called");
}

@end
