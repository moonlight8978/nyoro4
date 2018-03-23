class ReactService::Retweet::Destroy
  include ::ReactService::Destroy

  def react_class
    ::Feed::Retweet
  end
end
