//
//  ComposeViewController.m
//  twitter
//
//  Created by Angelina Zhang on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetTextField;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@property (nonatomic, strong) User *currentUser;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetTextField.layer.cornerRadius = self.tweetTextField.frame.size.width / 20;
    self.tweetTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.tweetTextField.layer.borderWidth = 2.4;
    self.tweetTextField.delegate = self;
    self.tweetTextField.text = @"Type here...";
    self.tweetTextField.textColor = [UIColor lightGrayColor];
    
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
    if (self.characterCountLabel.textColor == [UIColor redColor]) {
        [self displayErrorAlert:@"Your tweet is too long."];
    } else {
        [[APIManager shared]postStatusWithText:self.tweetTextField.text completion:^(Tweet *tweet, NSError *error) {
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
    if (self.tweetTextField.textColor == [UIColor lightGrayColor]) {
        self.tweetTextField.text = nil;
        self.tweetTextField.textColor = [UIColor blackColor];
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.tweetTextField.text length] == 0) {
        self.tweetTextField.text = @"Type here...";
        self.tweetTextField.textColor = [UIColor lightGrayColor];
        self.characterCountLabel.text = @"0";
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.characterCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.tweetTextField.text length]];
    int characterLimit = 140;
    if ([self.tweetTextField.text length] > characterLimit) {
        self.characterCountLabel.textColor = [UIColor redColor];
    } else {
        self.characterCountLabel.textColor = [UIColor blackColor];
    }
}

- (IBAction)onTapOutside:(id)sender {
    [self.tweetTextField endEditing:true];
}

@end
