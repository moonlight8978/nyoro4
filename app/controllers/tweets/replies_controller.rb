class Tweets::RepliesController < ApplicationController
  decorates_assigned :tweet

  def new
    @tweet = Feed::Tweet.find(params[:tweet_id]).decorate
    render layout: false
  end

  def create
    tweet = Feed::Tweet.find(params[:tweet_id])
    reply = tweet.replies.build(reply_params)
    reply.user = current_user
    reply.save
    head :ok
  end

  def update
    #code
  end

  def destroy
    #code
  end

private

  def reply_params
    params.require(:reply).permit(
      :content, :video, photos: []
    )
  end
end
