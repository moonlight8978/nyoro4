class HomeController < ApplicationController
  layout :determine_layout

  decorates_assigned :feeds

  def index
    @feeds = FeedDecorator.decorate_collection(
      Feed.all.includes(tweet: :user, retweet: [:tweet, :user], like: [:tweet, :user])
    )
  end

private

  def determine_layout
    user_signed_in? ? "application" : "full_page"
  end
end
