class Feed < ApplicationRecord
  TWEET_CLASS = Feed::Tweet.name
  RETWEET_CLASS = Feed::Retweet.name
  LIKE_CLASS = Feed::Like.name
  # associations
  # Polymorphic association used to show tweets, retweets and likes
  #   in homepage together
  belongs_to :feedable, polymorphic: true
  belongs_to :user
  # For eager loadings
  belongs_to :tweet,
    foreign_key: :feedable_id,
    foreign_type: TWEET_CLASS,
    class_name: TWEET_CLASS,
    optional: true
  belongs_to :retweet,
    foreign_key: :feedable_id,
    foreign_type: RETWEET_CLASS,
    class_name: RETWEET_CLASS,
    optional: true
  belongs_to :like,
    foreign_key: :feedable_id,
    foreign_type: LIKE_CLASS,
    class_name: LIKE_CLASS,
    optional: true

  # scopes
  default_scope { order(created_at: :desc) }

  scope :tweets, -> { where(feedable_type: TWEET_CLASS) }

  # class methods
  # Get all liked tweets of specific user
  # @note Should use with scope #tweets
  def self.liked_by(user)
    joins(tweet: :likes).where(feed_likes: { user_id: user.id })
  end

  # Get all tweets and retweets of specific user
  def self.tweets_of(user)
    includes(:tweet, :retweet)
      .where(
        "(feedable_type = ? AND feedable_id IN (?)) OR (feedable_type = ? AND feedable_id IN (?))",
        TWEET_CLASS,
        Feed::Tweet.select(:id).where(user: user),
        RETWEET_CLASS,
        Feed::Retweet.select(:id).where(user: user, retweetable_type: TWEET_CLASS)
      )
      .references(:feed_tweets, :feed_retweets)
  end

  def self.for(user)
    include_ids = user.followings.pluck(:id) << user.id
    self.where(user_id: include_ids)
  end
  # validates
  # callbacks
  after_initialize :store_user_id

  def store_user_id
    self.user = self.feedable.user
  end
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
    feedable_type == LIKE_CLASS
  end

  # If feed is a retweet
  def retweet?
    feedable_type == RETWEET_CLASS
  end

  # If feed is a thread
  def thread?
    false
  end
end
