class Tweets::RepliesController < ApplicationController
  def new
    @replyable =
      if params[:reply_id]
        Tweet::Reply.find(params[:reply_id]).decorate
      else
        Feed::Tweet.find(params[:tweet_id]).decorate
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

    partial =
      if params[:reply_id]
        'components/reply_reply'
      else
        'components/reply_tweet'
      end
    puts "ok"

    render partial: partial, object: reply.decorate, as: :reply, layout: false
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
