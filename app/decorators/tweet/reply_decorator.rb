class Tweet::ReplyDecorator < ApplicationDecorator
  include ::TweetDecorator
  decorates_association :replies, with: ::Tweet::ReplyDecorator

  def content
    if object.deleted
      h.t(:deleted, scope: "views.components.reply.content")
    else
      super
    end
  end

  def medias
    if object.deleted
      nil
    else
      super
    end
  end

  def reply_to
    reply_to = object.previous || object.tweet
    reply_to.decorate
  end

  # If current_user liked this tweet
  def liked?
    liked_ids = h.current_user.liked_replies.pluck(:id)
    liked_ids.include?(self.id)
  end

  # If current_user retweeted this tweet
  def retweeted?
    retweeted_ids = h.current_user.retweeted_replies.pluck(:id)
    retweeted_ids.include?(self.id)
  end

  def render_replies(&block)
    puts "asdasdadjsadjkls"
    if object.replies_count > 0
      h.capture(&block)
    end
  end

  def reply_path
    h.new_reply_reply_path(self.id)
  end

  def retweet_path
    h.retweet_reply_path(self.id)
  end

  def like_path
    h.like_reply_path(self.id)
  end

  def destroy_path
    h.reply_path(self.id)
  end
end
