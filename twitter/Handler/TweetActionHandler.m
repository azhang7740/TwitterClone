//
//  tweetActionHandler.m
//  twitter
//
//  Created by Angelina Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetActionHandler.h"

@implementation TweetActionHandler

- (void)favorite {
    self.tweet.favorited = !self.tweet.favorited;
    if (self.tweet.favorited) {
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet,
                                                                  NSError *error) {}];
    } else {
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet,
                                                                    NSError *error) {}];
    }
}

- (void)retweet {
    self.tweet.retweeted = !self.tweet.retweeted;
    if (self.tweet.retweeted) {
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet,
                                                                 NSError *error) {}];
    } else {
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet,
                                                                   NSError *error) {}];
    }
}

@end
