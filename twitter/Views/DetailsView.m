//
//  DetailsView.m
//  twitter
//
//  Created by Angelina Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsView.h"

@implementation DetailsView

- (IBAction)didTapRetweet:(id)sender {
    [self.detailsDelegate didTapRetweet];
}

- (IBAction)didTapFavorite:(id)sender {
    [self.detailsDelegate didTapFavorite];
}

- (IBAction)didTapReply:(id)sender {
    [self.detailsDelegate didTapReply];
}

@end
