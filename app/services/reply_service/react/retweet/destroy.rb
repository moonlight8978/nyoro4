class ReplyService::React::Retweet::Destroy
  include ::ReplyService::React::Destroy

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
