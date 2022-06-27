//
//  TweetCellModel.m
//  twitter
//
//  Created by Angelina Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCellDecorator.h"
#import "DateTools.h"
#import "TweetActionHandler.h"

@interface TweetCellDecorator() <TweetCellDelegate>

@end

@implementation TweetCellDecorator

- (instancetype)initWithTweet:(Tweet *)tweet {
    self.tweetData = tweet;
    return self;
}

- (void)loadNewCell:(TweetCell *) cell {
    self.tweetCell = cell;
    self.tweetCell.delegate = self;
    [self.tweetCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self updateCell];
}

- (void)updateCell {
    NSString *URLString = self.tweetData.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.tweetCell.profilePicture.image = [UIImage imageWithData:urlData];
    self.tweetCell.profilePicture.layer.cornerRadius = self.tweetCell.profilePicture.frame.size.width / 2;
    
    self.tweetCell.userDisplayName.text = self.tweetData.user.screenName;
    self.tweetCell.userAccountName.text = self.tweetData.user.name;
    
    self.tweetCell.tweetText.text = self.tweetData.text;
    self.tweetCell.tweetText.linkTextAttributes = @{NSForegroundColorAttributeName:UIColor.systemBlueColor};
    self.tweetCell.tweetText.dataDetectorTypes = UIDataDetectorTypeLink;
    
    self.tweetCell.displayDate.text = [self.tweetData.createdAtDate shortTimeAgoSinceNow];
    
    self.tweetCell.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweetData.retweetCount];
    self.tweetCell.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweetData.favoriteCount];
    
    [self updateRetweetFavorite];
}

- (void)updateRetweetFavorite {
    if (self.tweetData.retweeted) {
        self.tweetCell.retweetButton.selected = true;
    } else {
        self.tweetCell.retweetButton.selected = false;
    }
    
    if (self.tweetData.favorited) {
        self.tweetCell.favoriteButton.selected = true;
    } else {
        self.tweetCell.favoriteButton.selected = false;
    }
}

- (void)didTapFavorite {
    TweetActionHandler *tweetActions = [[TweetActionHandler alloc] init:self.tweetData];
    tweetActions.tweet = self.tweetData;
    [tweetActions favorite];
    [self updateCell];
}

- (void)didTapRetweet {
    TweetActionHandler *tweetActions = [[TweetActionHandler alloc] init:self.tweetData];
    tweetActions.tweet = self.tweetData;
    [tweetActions retweet];
    [self updateCell];
}

- (void)didTapReply {
    [self.delegate postReply:self.tweetData.idStr toUser:self.tweetData.user.screenName];
}


@end
