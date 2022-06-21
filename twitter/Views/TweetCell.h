//
//  TweetCell.h
//  twitter
//
//  Created by Angelina Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *userDisplayName;
@property (weak, nonatomic) IBOutlet UILabel *userAccountName;
@property (weak, nonatomic) IBOutlet UILabel *displayDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;


@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@property (nonatomic, strong) Tweet* cellTweet;

- (void)refreshData:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END
