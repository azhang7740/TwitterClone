//
//  TweetCell.m
//  twitter
//
//  Created by Angelina Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)refreshData:(Tweet *)tweet {
    self.cellTweet = tweet;
    [self refreshCurrentCell];
}

- (void)refreshCurrentCell {
    NSString *URLString = self.cellTweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profilePicture.image = [UIImage imageWithData:urlData];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    
    self.userDisplayName.text = self.cellTweet.user.screenName;
    self.userAccountName.text = self.cellTweet.user.name;
    self.tweetText.text = self.cellTweet.text;
    self.displayDate.text = self.cellTweet.createdAtString;
    
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.cellTweet.retweetCount];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.cellTweet.favoriteCount];
    
    [self updateRetweetFavorite];
}

- (void)updateRetweetFavorite {
    if (self.cellTweet.retweeted) {
        self.retweetButton.selected = true;
    } else {
        self.retweetButton.selected = false;
    }
    
    if (self.cellTweet.favorited) {
        self.favoriteButton.selected = true;
    } else {
        self.favoriteButton.selected = false;
    }
}

- (IBAction)didTapFavorite:(id)sender {
    self.cellTweet.favorited = !self.cellTweet.favorited;
    if (self.cellTweet.favorited) {
        self.cellTweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.cellTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    } else {
        self.cellTweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.cellTweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
    
    [self refreshCurrentCell];
}

@end
