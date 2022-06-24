# Project 2 - *TwitterClone*

**Name of your app** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **core** features are completed:

**A user should**

- [X] See an app icon in the home screen and a styled launch screen
- [X] Be able to log in using their Twitter account
- [X] See at latest the latest 20 tweets for a Twitter account in a Table View
- [X] Be able to refresh data by pulling down on the Table View
- [X] Be able to like and retweet from their Timeline view
- [X] Only be able to access content if logged in
- [X] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [X] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [X] See Tweet details in a Details view
- [X] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [X] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [X] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [X] Reply to any Tweet (**2 points**)
  - Replies should be prefixed with the username
  - The `reply_id` should be set when posting the tweet
- [X] See a character count when composing a Tweet (as well as a warning) (280 characters) (**1 point**)
- [X] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [ ] Click on a Profile image to reveal another user's profile page, including:
  - Header view: picture and tagline
  - Basic stats: #tweets, #following, #followers
- [ ] Switch between **timeline**, **mentions**, or **profile view** through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)

The following **additional** features are implemented:
- [X] Likes and retweet labels change based on the number of likes/retweets (0, 1, or plural)
- [X] Placeholder text on compose tweet text field appears when the text field is empty and disappears when typing
- [X] Refactored code into views, decorators, and data models
- [X] Replies show up in tweet details view
- [X] Can click into other tweets' details views if they show up as a reply to a particular details view tweet
- [X] Reply to replies to a particular tweet on details view

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to reduce code repetition when different view controllers have similar displays
2. The most effective/efficient way to use auto layout for better formatting

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<p float="left">
<img src='Demos/TwitterDemo1.gif' title='First demo' width='200' alt='Video Walkthrough' />
<img src='Demos/TwitterDemo2.gif' title='Second demo' width='200' alt='Video Walkthrough' />
<img src='Demos/TwitterDemo3.gif' title='Third demo' width='200' alt='Video Walkthrough' />
<img src='Demos/TwitterDemo6.gif' title='Third demo' width='200' alt='Video Walkthrough' />
</p>

<p float="left">
<img src='Demos/TwitterDemo4.gif' title='Fourth demo' width='200' alt='Video Walkthrough' />
<img src='Demos/TwitterDemo5.gif' title='Fifth demo' width='600' alt='Video Walkthrough' />
</p>

GIF created with [Kap](https://getkap.co/).

## Notes

Describe any challenges encountered while building the app.
- Learning how to use auto layout and not having conflicting constraints
- Interacting with the API (likes, retweets, creating new tweets, etc.)
- Having changes in one view affect the appearance of another view (interacting with a tweet in detail view -> returning to home)

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - date processing library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
