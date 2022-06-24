//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray<Tweet *> *tweets, NSError *error))completion;

- (void)getMoreHomeTimelineTweets:(NSString *)tweetId completion:(void(^)(NSArray<Tweet *> *tweets, NSError *error))completion;

- (void)getRepliesTo:(NSString *)tweetId withUserName:(NSString *)userName completion:(void(^)(NSArray<Tweet *> *tweets, NSError *error))completion;

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;

- (void)postStatusReplyWithText:(NSString *)text
                    replyToUser:(NSString *)userName
                 replyToTweetId:(NSString *) tweetId
                     completion:(void (^)(Tweet *, NSError *))completion;

- (void)getCurrentUserInfo:(void(^)(User *userInfo, NSError *error))completion;

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

@end
