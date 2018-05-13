class HomeController < ApplicationController
  layout :determine_layout

  decorates_assigned :feeds

  def index
    if user_signed_in?
      @feeds = FeedDecorator.decorate_collection(
        Feed.for(current_user).includes(tweet: :user, retweet: [:tweet, :user], like: [:tweet, :user])
      )
    end
  end

private

  def determine_layout
    user_signed_in? ? "application" : "full_page"
  end
end
