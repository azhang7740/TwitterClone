//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Angelina Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "DetailsView.h"
#import "DetailsDecorator.h"
#import "TweetCell.h"
#import "TweetCellDecorator.h"
#import "APIManager.h"

@interface TweetDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DetailsDecorator *detailsDecorator;
@property (weak, nonatomic) IBOutlet UITableView *tweetDetailsTableView;
@property (nonatomic, strong) NSMutableArray<TweetCellDecorator *> *tweetModels;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetDetailsTableView.dataSource = self;
    self.tweetDetailsTableView.delegate = self;
    
    self.detailsDecorator = [[DetailsDecorator alloc] initWithTweet:self.tweet];
    [self.detailsDecorator updateView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchReplies];
}

- (void)fetchReplies {
    self.tweetModels = [[NSMutableArray alloc] init];
    [[APIManager shared] getRepliesTo:self.tweet.idStr withUserName:self.tweet.user.screenName completion:^
     (NSArray<Tweet *> *tweets, NSError *error) {
        if (tweets) {
            for (Tweet *tweet in tweets) {
                [self.tweetModels addObject:[[TweetCellDecorator alloc] initWithTweet:tweet]];
            }
            [self.tweetDetailsTableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BOOL isDetailsCell = (indexPath.row == 0);
    if (isDetailsCell) {
        DetailsView *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsViewId" forIndexPath:indexPath];
        [self.detailsDecorator setView:cell];
        [self.detailsDecorator updateView];
        return cell;
    } else {
        TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetIdCell"
                                                          forIndexPath:indexPath];
        if (indexPath.row <= self.tweetModels.count) {
            [self.tweetModels[indexPath.row] loadNewCell:cell];
        }
        
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetModels.count;
}

@end
