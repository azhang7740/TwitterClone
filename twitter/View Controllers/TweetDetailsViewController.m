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
#import "ComposeViewController.h"

@interface TweetDetailsViewController () <DetailsDecoratorDelegate, ComposeViewControllerDelegate, TweetCellDecoratorDelegate, UITableViewDelegate, UITableViewDataSource>

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
    self.detailsDecorator.delegate = self;
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
        if (indexPath.row - 1 < self.tweetModels.count) {
            [self.tweetModels[indexPath.row - 1] loadNewCell:cell];
            self.tweetModels[indexPath.row - 1].delegate = self;
        }
        
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetModels.count + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = self.navigationController;
    TweetDetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetDetailsViewController"];
    if (indexPath.row != 0 &&
        indexPath.row - 1 < self.tweetModels.count) {
        viewController.tweet = self.tweetModels[indexPath.row - 1].tweetData;
        [navigationController pushViewController: viewController animated:YES];
    }
}

- (void)postReply:(NSString *)tweetId
           toUser:(NSString *)userName {
    UINavigationController *navigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ComposeNavigation"];
   [self presentViewController:navigationController animated:YES completion:nil];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
    composeController.replyTweetId = tweetId;
    composeController.replyUserName = userName;
}

- (void)postTweet:(nonnull Tweet *)tweet {
    if (tweet.repliedToTweet != nil && ![tweet.repliedToTweet isEqual:[NSNull null]] &&
        [tweet.repliedToTweet isEqual:self.tweet.idStr]) {
        [self.tweetModels insertObject:[[TweetCellDecorator alloc] initWithTweet:tweet] atIndex:0];
        [self.tweetDetailsTableView reloadData];
    }
}

@end
