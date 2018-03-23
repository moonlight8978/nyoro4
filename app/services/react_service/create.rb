module ReactService::Create
  # Return service object to create reaction to tweet
  def initialize(tweet, reactor)
    @tweet = tweet
    @reactor = reactor
  end

  # Perform the service. Create reaction then create feed for newfeeds
  def perform
    ActiveRecord::Base.transaction do
      react = react_class.create(user: reactor, tweet: tweet)
      react.create_feed
    end
  end

  def react_class
    self.class
  end

private

  attr_reader :tweet, :reactor
end
