//
//  ComposeViewDecorator.h
//  twitter
//
//  Created by Angelina Zhang on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"
#import "ComposeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeDecorator : NSObject

@property (nonatomic, strong) ComposeView *composeView;
@property (nonatomic, strong) User *currentUser;

- (instancetype)init:(ComposeView *)view
           inputUser:(User *)user;
- (void)updateView;
- (void)tapOutside;

@end

NS_ASSUME_NONNULL_END
