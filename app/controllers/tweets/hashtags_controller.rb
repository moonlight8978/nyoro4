class Tweets::HashtagsController < ApplicationController
  decorates_assigned :tweets

  def show
    @hashtag = ::Tweet::Hashtag.find_by!(name: params[:id].downcase)
    @tweets = @hashtag.tweets
    @hashtag_name = '#' + params[:id]
  end
end
