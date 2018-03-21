class ProfilesController < ApplicationController
  before_action :authenticate_user!, :find_user

  decorates_assigned :user, :user_following, :user_followers, :feeds

  def show
    @feeds = Feed.includes(tweet: :user).where("feed_tweets.user_id": user.id)
  end

  def followers
    @user_followers = UserDecorator.decorate_collection(@user.followers)
  end

  def following
    @user_following = UserDecorator.decorate_collection(@user.followings)
  end

  def likes
    #code
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
