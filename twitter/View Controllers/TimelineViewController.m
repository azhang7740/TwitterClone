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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<Tweet *> *arrayOfTweets;
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
    
    [self fetchTweets];
}

- (void)fetchTweets {
    [[APIManager shared] getHomeTimelineWithCompletion:^
     (NSArray<Tweet *> *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = (NSMutableArray<Tweet *> *)tweets;
            [self.homeTweetTableView reloadData];
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard
                                                instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetIdCell"
                                                      forIndexPath:indexPath];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    [cell refreshData:tweet];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
    [refreshControl endRefreshing];
}

@end
