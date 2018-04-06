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
      users = tweet.extract_mentioned_users
      hashtags = tweet.extract_hashtags

      ActiveRecord::Base.transaction do
        tweet.save
        @feed = tweet.create_feed
        hashtags.map do |name|
          hashtag = ::Tweet::Hashtag.find_or_create_by(name: name)
          tagging = ::Tweet::Tagging.create(hashtag: hashtag, taggable: tweet)
        end
        users.map do |user|
          mentioning = ::Tweet::Mentioning.create(mentionable: tweet, user: user)
        end
      end
    end

  private

    attr_reader :extractor, :tweet, :user
  end
end
