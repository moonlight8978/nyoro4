module TweetService
  # Use to create tweet after validating
  # The data must be sure 100% valid
  class Create
    # @param user  [User]         user who tweeted
    # @param tweet [Feed::Tweet]  valid tweet
    def initialize(user, tweet)
      @user = user
      @tweet = tweet
      @extractor = Nyoro::Text::Extractor.new
    end

    # Perform the service
    def perform
      content = tweet.content
      names = extractor.extract_mentioned_screen_names(content)
      hashtags = extractor.extract_hashtags(content)
      p names, hashtags
      
      ActiveRecord::Base.transaction do
        tweet.save
        tweet.create_feed
      end
    end

  private

    attr_reader :extractor, :tweet, :user
  end
end
