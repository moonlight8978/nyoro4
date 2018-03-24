module ReactService::Create
  # Return service object to create reaction to tweet
  def initialize(tweet, reactor)
    @tweet = tweet
    @reactor = reactor
  end

  # Perform the service. Create reaction then create feed for newfeeds
  def perform
    ActiveRecord::Base.transaction do
      react = react_class.create(user: reactor, "#{reactable}": tweet)
      react.create_feed
    end
  end

protected

  # Return class for reaction
  def react_class
    self.class
  end

  # Return reactable association key
  def reactable
    raise NoMethodError, "You must implement this method in subclasses"
  end

private

  attr_reader :tweet, :reactor
end
