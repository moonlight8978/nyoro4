class HomeController < ApplicationController 
  layout :determine_layout

  decorates_assigned :user, :feeds

  def index
    @user = current_user
    @feeds = FeedDecorator.decorate_collection(
      Feed.all.includes(tweet: :user)
    )
  end

private

  def determine_layout
    user_signed_in? ? "application" : "full_page"
  end
end
