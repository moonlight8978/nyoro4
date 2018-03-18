class TweetForm < ApplicationForm
  delegate :content, :user_id, :pinned, to: :tweet

  attr_accessor :params, :tweet, :user

  validates :content, presence: true

  # Build form from user, use to create form to writing tweet
  # @param user [User] should be current user
  def self.from_user(user)
    self.new(tweet: Feed::Tweet.new(user: user))
  end

  # Build form from exist tweet, use when update tweet
  # @param tweet [Feed::Tweet]
  def self.from_tweet(tweet)
    self.new(tweet: tweet)
  end

  # Build form from user's posted params, use when user tweet
  # @param user [User]          user who tweeted, should be current user
  # @param params [Parameters]  rails built-in unpermitted params
  def self.from_params(user, params)
    self.new(user: user, params: params)
  end

  # Return tweet
  def tweet
    return @tweet if @tweet
    @tweet = Feed::Tweet.new(tweet_params)
    @tweet.tap do |t|
      t.user = user
    end
  end

private
  # Permit strong parameters
  def tweet_params
    params.require(:tweet).permit(
      :content, :video, photos: []
    )
  end
end
