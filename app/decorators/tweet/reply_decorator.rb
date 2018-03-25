class Tweet::ReplyDecorator < ApplicationDecorator
  include ::TweetDecorator
  decorates_association :replies, with: ::Tweet::ReplyDecorator
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

  def render_replies
    if object.replies.size > 0
      h.render partial: 'components/reply_reply', collection: self.replies, as: :reply
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
end
