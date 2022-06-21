//
//  Tweet.h
//  twitter
//
//  Created by Angelina Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

/// For favoriting, retweeting & replying
@property (nonatomic, strong) NSString *idStr;
/// Text content of tweet
@property (nonatomic, strong) NSString *text;
/// Update favorite count label
@property (nonatomic) int favoriteCount;
/// Configure favorite button
@property (nonatomic) BOOL favorited;
/// Update retweet count label
@property (nonatomic) int retweetCount;
/// Configure retweet button
@property (nonatomic) BOOL retweeted;
/// Contains Tweet author's name, screenname, etc.
@property (nonatomic, strong) User *user;
/// Display date
@property (nonatomic, strong) NSString *createdAtString;

/// For Retweets: If the tweet is a retweet, this will be the user who retweeted
@property (nonatomic, strong) User *retweetedByUser;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
