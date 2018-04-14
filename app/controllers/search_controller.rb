class SearchController < ApplicationController
  before_action :authenticate_user!

  decorates_assigned :users, :hashtags, :tweets

  def users
    results = ::User.search(
      params[:q],
      search_params.merge({ fields: [:username, :profilename] })
    )
    @users = UserDecorator.decorate_collection(results)
  end

  # def hashtags
  #   @hashtags = ::Tweet::Hashtag.search(
  #     params[:q],
  #     search_params.merge({ fields: [:name] })
  #   )
  # end

  def tweets
    results = ::Feed::Tweet.search(
      params[:q],
      search_params.merge({ fields: [:content], match: :word })
    )
    @tweets = Feed::TweetDecorator.decorate_collection(results)
  end

private

  def search_params
    {
      page: params[:page] || 1,
      per_page: params[:per_page] || 20,
      match: :word_middle
    }
  end
end
