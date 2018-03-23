module ReactService::Destroy
  # Return service object to delete reaction to tweet
  def initialize(tweet, reactor)
    @tweet = tweet
    @reactor = reactor
  end

  # Perform the service. Create reaction then create feed for newfeeds
  def perform
    ActiveRecord::Base.transaction do
      react_class
        .find_by(user: reactor, tweet: tweet)
        .destroy
    end
  end

  # Return class for reaction
  def react_class
    raise NoMethodError, "You need to implement this method in subclasses"
  end

private

  attr_reader :tweet, :reactor
end
