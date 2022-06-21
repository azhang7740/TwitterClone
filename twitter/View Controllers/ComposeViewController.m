//
//  ComposeViewController.m
//  twitter
//
//  Created by Angelina Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextField;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;

@property (nonatomic, strong) User *currentUser;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetTextField.layer.cornerRadius = self.tweetTextField.frame.size.width / 20;
    self.tweetTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.tweetTextField.layer.borderWidth = 2.4;
    
    [self fetchUserProfilePicture];
}

- (void)fetchUserProfilePicture {
    [[APIManager shared] getCurrentUserInfo:^(User *user, NSError *error) {
        if (user) {
            NSLog(@"Successfully loaded user profile");
            self.currentUser = user;
        } else {
            NSLog(@"Error getting home timeline: %@",
                  error.localizedDescription);
        }
        [self setUserProfilePicture];
    }];
}

- (void)setUserProfilePicture {
    NSString *URLString;
    if (self.currentUser) {
        URLString = self.currentUser.profilePicture;
    } else {
        URLString = @"https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png";
    }
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.userProfileImage.image = [UIImage imageWithData:urlData];
    self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.width / 2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTapClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapTweet:(id)sender {
    [[APIManager shared]postStatusWithText:@"This is my tweet 😀" completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
