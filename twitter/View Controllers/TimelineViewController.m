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
#import "TweetCellModel.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<TweetCellModel *> *tweetModels;
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
                [self.tweetModels addObject:[[TweetCellModel alloc] initWithTweet:tweet]];
            }
            [self.homeTweetTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didTweet:(Tweet *)tweet {
    [self.tweetModels insertObject:[[TweetCellModel alloc] initWithTweet:tweet] atIndex:0];
    [self.homeTweetTableView reloadData];
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
    [self.tweetModels[indexPath.row] loadNewCell:cell];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetModels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = self.navigationController;
    TweetDetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetDetailsViewController"];
    viewController.tweet = self.tweetModels[indexPath.row].tweetData;
    [navigationController pushViewController: viewController animated:YES];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
    [refreshControl endRefreshing];
}

@end
