class Tweets::RepliesController < ApplicationController
  decorates_assigned :replies

  def index
    @replies =
      if params[:reply_id]
        Tweet::Reply
          .includes(replies: [{ previous: :user }, :user])
          .find(params[:reply_id])
      else
        Feed::Tweet.find(params[:tweet_id])
      end
      .replies
    render layout: false
  end

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
    if params[:reply_id]
      reply_to, service_class, partial = [
        Tweet::Reply.find(params[:reply_id]),
        ReplyService::Reply::Create,
        'components/reply_reply'
      ]
      form = ReplyForm.from_reply(reply_to, current_user, params)
    else
      reply_to, service_class, partial = [
        Feed::Tweet.find(params[:tweet_id]),
        ReplyService::Tweet::Create,
        'components/reply_tweet'
      ]
      form = ReplyForm.from_tweet(reply_to, current_user, params)
    end

    if form.valid?
      service = service_class.new(form.reply, reply_to, current_user)
      service.perform
      render partial: partial, object: service.reply.decorate, as: :reply, layout: false
    else
      p form.errors
      head :bad_request
    end
  end

  def update
    reply = Tweet::Reply.accessible_by(current_ability, :crud).find(params[:id])
  end

  def destroy
    reply = Tweet::Reply.accessible_by(current_ability, :crud).find(params[:id])
    service = ::ReplyService::Destroy.new(reply)
    service.perform
    render partial: 'components/reply_reply', object: reply.decorate, as: :reply, layout: false
  end

private

  def reply_params
    params.require(:reply).permit(
      :content, :video, photos: []
    )
  end
end
