//
//  TweetCellModel.h
//  twitter
//
//  Created by Angelina Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetCell.h"
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCellModel : NSObject

@property (nonatomic, strong) Tweet* tweetData;
@property (nonatomic, strong) TweetCell * tweetCell;

- (void)loadNewCell:(TweetCell *) cell;
- (instancetype)initWithTweet:(Tweet *) tweet;
- (void)updateCell;

@end

NS_ASSUME_NONNULL_END
