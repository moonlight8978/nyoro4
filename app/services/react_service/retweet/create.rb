class ReactService::Retweet::Create
  include ::ReactService::Create

protected

  def react_class
    ::Feed::Retweet
  end

  def reactable
    'retweetable'
  end

  def counter_column
    'retweets_count'
  end
end
