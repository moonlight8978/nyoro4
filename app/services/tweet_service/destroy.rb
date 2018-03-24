module TweetService
  # Use to delete tweet
  class Destroy
    # @param tweet [Feed::Tweet] Tweet need to delete
    def initialize(tweet)
      @tweet = tweet
    end

    # Perform the service
    def perform
      retweets = Feed::Retweet.reacted_to(tweet)
      likeds = Feed::Like.reacted_to(tweet)
      ActiveRecord::Base.transaction do
        retweets.destroy_all
        likeds.destroy_all
        tweet.destroy
      end
    end

  private

    attr_reader :tweet
  end
end
