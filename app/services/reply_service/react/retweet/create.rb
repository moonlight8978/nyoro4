class ReplyService::React::Retweet::Create
  include ::ReplyService::React::Create

protected

  def reactable
    'retweetable'
  end

  def react_class
    ::Feed::Retweet
  end

  def counter_column
    'retweets_count'
  end
end
