//
//  ComposeViewDecorator.m
//  twitter
//
//  Created by Angelina Zhang on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeDecorator.h"
#import "APIManager.h"

@interface ComposeDecorator() <UITextViewDelegate>

@end

@implementation ComposeDecorator

- (instancetype)init:(ComposeView *)view
           inputUser:(User *)user {
    self.composeView = view;
    self.currentUser = user;
    
    return self;
}

- (void)updateView {
    self.composeView.tweetTextField.layer.cornerRadius = self.composeView.tweetTextField.frame.size.width / 20;
    self.composeView.tweetTextField.layer.borderColor = [UIColor.grayColor CGColor];
    self.composeView.tweetTextField.layer.borderWidth = 2.4;
    self.composeView.tweetTextField.delegate = self;
    self.composeView.tweetTextField.text = @"Type here...";
    self.composeView.tweetTextField.textColor = UIColor.lightGrayColor;
    
    [self fetchUserProfilePicture];
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

- (void)fetchUserProfilePicture {
    [[APIManager shared] getCurrentUserInfo:^(User *user, NSError *error) {
        if (user) {
            self.currentUser = user;
        }
        [self setUserProfilePicture];
    }];
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
    int characterLimit = 280;
    if ([self.composeView.tweetTextField.text length] > characterLimit) {
        self.composeView.characterCountLabel.textColor = UIColor.redColor;
    } else {
        self.composeView.characterCountLabel.textColor = UIColor.blackColor;
    }
}

- (void) tapOutside {
    [self.composeView.tweetTextField endEditing:true];
}

@end
