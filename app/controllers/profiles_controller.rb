class ProfilesController < ApplicationController
  before_action :authenticate_user!, :find_user

  decorates_assigned :user, :user_following, :user_followers, :feeds

  def show
    @feeds = Feed.tweets_of(user)
  end

  def followers
    @user_followers = UserDecorator.decorate_collection(@user.followers)
  end

  def following
    @user_following = UserDecorator.decorate_collection(@user.followings)
  end

  def likes
    @feeds = Feed.where(id: @user.likeds)
  end

  def mentions
    @mentioned_tweets = @user.mentioned_tweets
    @feeds = Feed
      .includes(tweet: [:user])
      .where(feedable: @mentioned_tweets)
  end

  def current_user_profile?
    @user == current_user
  end

  helper_method :current_user_profile?

private

  def find_user
    @user = User.find(params[:user_id])
  end
end
