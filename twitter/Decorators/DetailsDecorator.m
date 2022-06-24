//
//  DetailsModel.m
//  twitter
//
//  Created by Angelina Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsDecorator.h"
#import "APIManager.h"
#import "TweetActionHandler.h"

@interface DetailsDecorator() <DetailsViewDelegate>

@end

@implementation DetailsDecorator

- (instancetype)init:(Tweet *)tweet
         detailsView:(DetailsView *)view {
    self.tweetData = tweet;
    self.detailsView = view;
    self.detailsView.detailsDelegate = self;
    return self;
}

- (void)updateView {
    [self setProfilePicture];
    [self setUserTweetText];
    [self setPostDateTime];
    [self setFavoritesAndRetweets];
}

- (void)setProfilePicture {
    NSString *URLString = self.tweetData.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.detailsView.profilePictureImage.image = [UIImage imageWithData:urlData];
    self.detailsView.profilePictureImage.layer.cornerRadius = self.detailsView.profilePictureImage.frame.size.width / 2;
}

- (void)setUserTweetText {
    self.detailsView.nameLabel.text = self.tweetData.user.name;
    self.detailsView.screenNameLabel.text = [@"@" stringByAppendingString:self.tweetData.user.screenName];
    self.detailsView.tweetBodyLabel.text = self.tweetData.text;
}

- (void)setPostDateTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"h:mm"];
    self.detailsView.postTimeLabel.text = [dateFormatter stringFromDate:self.tweetData.createdAtDate];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"MMM d, yyyy"];
    self.detailsView.postDateLabel.text = [dateFormatter stringFromDate:self.tweetData.createdAtDate];
}

- (void)setFavoritesAndRetweets {
    if (self.tweetData.retweetCount == 1) {
        self.detailsView.retweetsLabel.text = [[NSString stringWithFormat:@"%d", self.tweetData.retweetCount] stringByAppendingString:@" retweet  "];
    } else if (self.tweetData.retweetCount > 0) {
        self.detailsView.retweetsLabel.text = [[NSString stringWithFormat:@"%d", self.tweetData.retweetCount] stringByAppendingString:@" retweets   "];
    } else {
        self.detailsView.retweetsLabel.text = @"";
    }
    self.detailsView.retweetButton.selected = self.tweetData.retweeted;
    
    if (self.tweetData.favoriteCount == 1) {
        self.detailsView.favoriteLabel.text = [[NSString stringWithFormat:@"%d", self.tweetData.favoriteCount] stringByAppendingString:@" like"];
    } else if (self.tweetData.favoriteCount > 0) {
        self.detailsView.favoriteLabel.text = [[NSString stringWithFormat:@"%d", self.tweetData.favoriteCount] stringByAppendingString:@" likes"];
    } else {
        self.detailsView.favoriteLabel.text = @"";
    }
    self.detailsView.favoriteButton.selected = self.tweetData.favorited;
}

- (void)didTapFavorite {
    TweetActionHandler *tweetActions = [[TweetActionHandler alloc] init:self.tweetData];
    tweetActions.tweet = self.tweetData;
    [tweetActions favorite];
    [self setFavoritesAndRetweets];
}

- (void)didTapRetweet {
    TweetActionHandler *tweetActions = [[TweetActionHandler alloc] init:self.tweetData];
    tweetActions.tweet = self.tweetData;
    [tweetActions retweet];
    [self setFavoritesAndRetweets];
}

@end
