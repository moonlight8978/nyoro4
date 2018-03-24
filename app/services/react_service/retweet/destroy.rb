class ReactService::Retweet::Destroy
  include ::ReactService::Destroy

protected

  def react_class
    ::Feed::Retweet
  end

  def reactable
    'retweetable'
  end
end
