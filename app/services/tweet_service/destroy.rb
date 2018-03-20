module TweetService
  # Use to delete tweet
  class Destroy
    # @param tweet [Feed::Tweet] Tweet need to delete
    def initialize(tweet)
      @tweet = tweet
    end

    # Perform the service
    def perform
      feed = tweet.feed
      ActiveRecord::Base.transaction do
        feed.destroy
      end
    end

  private

    attr_reader :tweet
  end
end
