//
//  Tweet.m
//  twitter
//
//  Created by Angelina Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    NSMutableDictionary *rawTweet = [dictionary copy];
    if (self) {
        NSDictionary *originalTweet = rawTweet[@"retweeted_status"];
        BOOL isReTweet = (originalTweet != nil);
        if (isReTweet) {
            NSDictionary *userDictionary = rawTweet[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            rawTweet = (NSMutableDictionary *)originalTweet;
        }
        
        self.idStr = rawTweet[@"id_str"];
        if([rawTweet valueForKey:@"full_text"] != nil) {
            self.text = rawTweet[@"full_text"];
        } else {
            self.text = rawTweet[@"text"];
        }
        self.favoriteCount = [rawTweet[@"favorite_count"] intValue];
        self.favorited = [rawTweet[@"favorited"] boolValue];
        self.retweetCount = [rawTweet[@"retweet_count"] intValue];
        self.retweeted = [rawTweet[@"retweeted"] boolValue];

        NSDictionary *user = rawTweet[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        NSString *createdAtOriginalString = rawTweet[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";

        NSDate *date = [formatter dateFromString:createdAtOriginalString];

        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;

        self.createdAtString = [formatter stringFromDate:date];
        self.createdAtDate = date;
        self.repliedToTweet = rawTweet[@"in_reply_to_status_id_str"];
    }
    return self;
}

+ (NSMutableArray<Tweet *> *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray<Tweet *> *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
