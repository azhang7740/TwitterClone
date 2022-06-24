//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Angelina Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "DetailsView.h"
#import "DetailsModel.h"

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet DetailsView *detailsView;
@property (nonatomic, strong) DetailsModel *detailsModel;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailsModel = [[DetailsModel alloc] init:self.tweet detailsView:self.detailsView];
    [self.detailsModel updateView];
}

@end
