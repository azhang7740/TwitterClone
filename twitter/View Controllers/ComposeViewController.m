//
//  ComposeViewController.m
//  twitter
//
//  Created by Angelina Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeView.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet ComposeView *composeView;
@property (nonatomic, strong) User *currentUser;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureComposeView];
}

- (void)configureComposeView {
    self.composeView.tweetTextField.layer.cornerRadius = self.composeView.tweetTextField.frame.size.width / 20;
    self.composeView.tweetTextField.layer.borderColor = [UIColor.grayColor CGColor];
    self.composeView.tweetTextField.layer.borderWidth = 2.4;
    self.composeView.tweetTextField.delegate = self;
    self.composeView.tweetTextField.text = @"Type here...";
    self.composeView.tweetTextField.textColor = UIColor.lightGrayColor;
    
    [self fetchUserProfilePicture];
}

- (void)fetchUserProfilePicture {
    [[APIManager shared] getCurrentUserInfo:^(User *user, NSError *error) {
        if (user) {
            self.currentUser = user;
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
    self.composeView.userProfileImage.image = [UIImage imageWithData:urlData];
    self.composeView.userProfileImage.layer.cornerRadius = self.composeView.userProfileImage.frame.size.width / 2;
}

- (IBAction)onTapClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapTweet:(id)sender {
    if (self.composeView.characterCountLabel.textColor == [UIColor redColor]) {
        [self displayErrorAlert:@"Your tweet is too long."];
    } else {
        [[APIManager shared]postStatusWithText:self.composeView.tweetTextField.text completion:^(Tweet *tweet, NSError *error) {
            if(error){
                [self displayErrorAlert:@"Your tweet didn't post successfully."];
            } else {
                [self.delegate didTweet:tweet];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}

- (void)displayErrorAlert:(NSString *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!" message:error preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated: YES completion: nil];
    UIAlertAction * closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        }];
    [alertController addAction:closeAction];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.composeView.tweetTextField.textColor == UIColor.lightGrayColor) {
        self.composeView.tweetTextField.text = nil;
        self.composeView.tweetTextField.textColor = UIColor.blackColor;
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.composeView.tweetTextField.text length] == 0) {
        self.composeView.tweetTextField.text = @"Type here...";
        self.composeView.tweetTextField.textColor = UIColor.lightGrayColor;
        self.composeView.characterCountLabel.text = @"0";
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.composeView.characterCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.composeView.tweetTextField.text length]];
    int characterLimit = 140;
    if ([self.composeView.tweetTextField.text length] > characterLimit) {
        self.composeView.characterCountLabel.textColor = UIColor.redColor;
    } else {
        self.composeView.characterCountLabel.textColor = UIColor.blackColor;
    }
}

- (IBAction)onTapOutside:(id)sender {
    [self.composeView.tweetTextField endEditing:true];
}

@end
