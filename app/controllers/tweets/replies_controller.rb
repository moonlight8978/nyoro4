class Tweets::RepliesController < ApplicationController
  def new
    if params[:reply_id]
      @replyable = Tweet::Reply.find(params[:reply_id]).decorate
    else
      @replyable = Feed::Tweet.find(params[:tweet_id]).decorate
    end

    render layout: false
  end

  def create
    replyable =
      if params[:reply_id]
        Tweet::Reply.find(params[:reply_id])
      else
        Feed::Tweet.find(params[:tweet_id])
      end
    reply = replyable.replies.build(reply_params)

    if params[:reply_id]
      reply.tweet_id = replyable.tweet_id
    end
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
