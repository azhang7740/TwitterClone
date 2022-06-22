//
//  TweetCell.h
//  twitter
//
//  Created by Angelina Zhang on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet* cellTweet;

- (void)refreshData:(Tweet *)tweet;

- (void)refreshCurrentCell;

@end

NS_ASSUME_NONNULL_END
