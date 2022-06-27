//
//  TweetCell.m
//  twitter
//
//  Created by Angelina Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "DateTools.h"

@interface TweetCell()

@end

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)didTapFavorite:(id)sender {
    [self.delegate didTapFavorite];
}

- (IBAction)didTapRetweet:(id)sender {
    [self.delegate didTapRetweet];
}

- (IBAction)didTapReply:(id)sender {
    [self.delegate didTapReply];
}

@end
