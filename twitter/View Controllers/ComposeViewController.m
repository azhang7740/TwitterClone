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
#import "ComposeDecorator.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet ComposeView *composeView;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) ComposeDecorator *decorator;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.decorator = [[ComposeDecorator alloc] init:self.composeView inputUser:self.currentUser];
    [self.decorator updateView];
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
                [self.delegate postTweet:tweet];
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

- (IBAction)onTapOutside:(id)sender {
    [self.decorator tapOutside];
}

@end
