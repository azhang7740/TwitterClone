//
//  tweetActionHandler.h
//  twitter
//
//  Created by Angelina Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetActionHandler : NSObject

- (void)favorite;
- (void)retweet;
@property (nonatomic, strong) Tweet* tweet;

@end

NS_ASSUME_NONNULL_END
