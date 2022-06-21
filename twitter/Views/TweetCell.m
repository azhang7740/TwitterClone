//
//  TweetCell.m
//  twitter
//
//  Created by Angelina Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshData:(Tweet *)tweet {
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profilePicture.image = [UIImage imageWithData:urlData];
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    
    self.userDisplayName.text = tweet.user.screenName;
    self.userAccountName.text = tweet.user.name;
    self.tweetText.text = tweet.text;
    self.displayDate.text = tweet.createdAtString;
    
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
}

@end
