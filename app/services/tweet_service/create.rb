module TweetService
  # Use to create tweet after validating
  # The data must be sure 100% valid
  class Create
    # Get the feed has been created
    attr_reader :feed

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

      ActiveRecord::Base.transaction do
        tweet.save
        @feed = tweet.create_feed
        ::Tweet::Tagging.tag(tweet)
        ::Tweet::Mentioning.mention(tweet)
      end
    end

  private

    attr_reader :extractor, :tweet, :user
  end
end
