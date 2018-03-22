module TweetService
  # Use to delete tweet
  class Destroy
    # @param tweet [Feed::Tweet] Tweet need to delete
    def initialize(tweet)
      @tweet = tweet
    end

    # Perform the service
    def perform
      ActiveRecord::Base.transaction do
        tweet.destroy
      end
    end

  private

    attr_reader :tweet
  end
end
