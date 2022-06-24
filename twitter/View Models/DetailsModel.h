//
//  DetailsModel.h
//  twitter
//
//  Created by Angelina Zhang on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"
#import "DetailsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsModel : NSObject

@property (nonatomic, strong) Tweet* tweetData;
@property (nonatomic, strong) DetailsView * detailsView;

- (instancetype)init:(Tweet *)tweet
         detailsView: (DetailsView *)view;
- (void)updateView;

@end

NS_ASSUME_NONNULL_END
