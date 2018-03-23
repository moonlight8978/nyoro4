class ReactService::Retweet::Create
  include ::ReactService::Create

  def react_class
    ::Feed::Retweet
  end
end
