//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetDetailsViewController.h"
#import "TweetCellDecorator.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, TweetCellDecoratorDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<TweetCellDecorator *> *tweetModels;
@property (weak, nonatomic) IBOutlet UITableView *homeTweetTableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeTweetTableView.dataSource = self;
    self.homeTweetTableView.delegate = self;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.homeTweetTableView insertSubview:refreshControl atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchTweets];
}

- (void)fetchTweets {
    self.tweetModels = [[NSMutableArray alloc] init];
    [[APIManager shared] getHomeTimelineWithCompletion:^
     (NSArray<Tweet *> *tweets, NSError *error) {
        if (tweets) {
            for (Tweet *tweet in tweets) {
                [self.tweetModels addObject:[[TweetCellDecorator alloc] initWithTweet:tweet]];
            }
            [self.homeTweetTableView reloadData];
        }
    }];
}

- (void)fetchMoreTweets:(NSString *)tweetId {
    [[APIManager shared] getMoreHomeTimelineTweets:tweetId completion:^ (NSArray<Tweet *> *tweets, NSError *error) {
        if (tweets) {
            for (int i = 1; i < tweets.count; i++) {
                [self.tweetModels addObject:[[TweetCellDecorator alloc] initWithTweet:tweets[i]]];
            }
            [self.homeTweetTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)postTweet:(Tweet *)tweet {
    if (tweet.repliedToTweet == nil || [tweet.repliedToTweet isEqual:[NSNull null]]) {
        [self.tweetModels insertObject:[[TweetCellDecorator alloc] initWithTweet:tweet] atIndex:0];
        [self.homeTweetTableView reloadData];
    }
}

- (IBAction)onTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard
                                                instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetIdCell"
                                                      forIndexPath:indexPath];
    if (indexPath.row < self.tweetModels.count) {
        [self.tweetModels[indexPath.row] loadNewCell:cell];
        self.tweetModels[indexPath.row].delegate = self;
        if (indexPath.row == self.tweetModels.count - 1) {
            [self fetchMoreTweets:self.tweetModels[indexPath.row].tweetData.idStr];
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetModels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = self.navigationController;
    TweetDetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetDetailsViewController"];
    if (indexPath.row < self.tweetModels.count) {
        viewController.tweet = self.tweetModels[indexPath.row].tweetData;
        [navigationController pushViewController: viewController animated:YES];
    }
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
    [refreshControl endRefreshing];
}

- (void)postReply:(nonnull NSString *)tweetId toUser:(nonnull NSString *)userName {
    UINavigationController *navigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ComposeNavigation"];
   [self presentViewController:navigationController animated:YES completion:nil];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
    composeController.replyTweetId = tweetId;
    composeController.replyUserName = userName;
}

@end
