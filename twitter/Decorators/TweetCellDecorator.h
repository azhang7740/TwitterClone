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

@protocol TweetCellDecoratorDelegate

- (void)postReply:(NSString *)tweetId
           toUser:(NSString *)userName;

@end

@interface TweetCellDecorator : NSObject

@property (nonatomic, strong) Tweet* tweetData;
@property (nonatomic, strong) TweetCell * tweetCell;
@property (nonatomic, weak) id<TweetCellDecoratorDelegate> delegate;

- (instancetype)initWithTweet:(Tweet *) tweet;
- (void)loadNewCell:(TweetCell *) cell;
- (void)updateCell;

@end

NS_ASSUME_NONNULL_END
