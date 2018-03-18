class Feed < ApplicationRecord
  TWEET_CLASS = Feed::Tweet.name
  # associations
  # Polymorphic association used to show tweets, retweets and likes
  #   in homepage together
  belongs_to :feedable, polymorphic: true
  # For eager loadings
  belongs_to :tweet, foreign_key: :feedable_id, foreign_type: TWEET_CLASS, class_name: TWEET_CLASS
  # scopes
  default_scope { order(created_at: :desc) }
  # class methods
  # validates
  # callbacks
  # instance methods
  # Call all tweet's method from feed
  # def method_missing(method, *args, &block)
  #   if tweet?
  #     tweet.send(method)
  #   elsif
  #     raise NoMethodError
  #   end
  # end

  # If feed is a tweet
  def tweet?
    feedable_type == TWEET_CLASS
  end

  # If feed is a like
  def like?
    false
  end

  # If feed is a retweet
  def retweet?
    false
  end

  # If feed is a thread
  def thread?
    false
  end
end
