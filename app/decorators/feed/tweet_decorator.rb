class Feed::TweetDecorator < ApplicationDecorator
  include ::TweetDecorator

  def replies
    ::Tweet::ReplyDecorator.decorate_collection(object.replies.root)
  end
  # If current_user liked this tweet
  def liked?
    liked_ids = h.current_user.liked_tweets.pluck(:id)
    liked_ids.include?(self.id)
  end

  # If current_user retweeted this tweet
  def retweeted?
    retweeted_ids = h.current_user.retweeted_tweets.pluck(:id)
    retweeted_ids.include?(self.id)
  end

  def reply_path
    h.new_tweet_reply_path(self.id)
  end

  def retweet_path
    h.retweet_tweet_path(self.id)
  end

  def like_path
    h.like_tweet_path(self.id)
  end
end
