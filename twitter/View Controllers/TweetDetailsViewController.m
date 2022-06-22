//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Angelina Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *tweetBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *retweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProfilePicture];
    [self setUserTweetText];
    [self setPostDateTime];
    [self setFavoritesAndRetweets];
}

- (void)setProfilePicture {
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profilePictureImage.image = [UIImage imageWithData:urlData];
    self.profilePictureImage.layer.cornerRadius = self.profilePictureImage.frame.size.width / 2;
}

- (void)setUserTweetText {
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetBodyLabel.text = self.tweet.text;
}

- (void)setPostDateTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"h:mm"];
    self.postTimeLabel.text = [dateFormatter stringFromDate:self.tweet.createdAtDate];
    [dateFormatter setLocalizedDateFormatFromTemplate:@"MMM d, yyyy"];
    self.postDateLabel.text = [dateFormatter stringFromDate:self.tweet.createdAtDate];
}

- (void)setFavoritesAndRetweets {
    if (self.tweet.retweetCount == 1) {
        self.retweetsLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.retweetCount] stringByAppendingString:@" retweet"];
    } else if (self.tweet.retweetCount > 0) {
        self.retweetsLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.retweetCount] stringByAppendingString:@" retweets"];
    } else {
        self.retweetsLabel.text = @"";
    }
    self.retweetButton.selected = self.tweet.retweeted;
    
    if (self.tweet.favoriteCount == 1) {
        self.favoriteLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:@" like"];
    } else if (self.tweet.favoriteCount > 0) {
        self.favoriteLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:@" likes"];
    } else {
        self.favoriteLabel.text = @"";
    }
    self.favoriteButton.selected = self.tweet.favorited;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
