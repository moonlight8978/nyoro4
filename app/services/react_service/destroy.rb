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
        .find_by(user: reactor, "#{reactable}": tweet)
        .destroy
    end
  end

protected

  # Return class for reaction
  def react_class
    raise NoMethodError, "You need to implement this method in subclasses"
  end

  # Return reactable association key
  def reactable
    raise NoMethodError, "You must implement this method in subclasses"
  end

private

  attr_reader :tweet, :reactor
end
