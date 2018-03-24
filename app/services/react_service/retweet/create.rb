class ReactService::Retweet::Create
  include ::ReactService::Create

protected

  def react_class
    ::Feed::Retweet
  end

  def reactable
    'retweetable'
  end
end
