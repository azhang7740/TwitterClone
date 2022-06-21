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

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [[APIManager shared] postStatusWithText:self.tweetTextField.text completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            NSLog(@"Successfully posted tweet");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
