class ReplyService::React::Like::Create
  include ::ReplyService::React::Create

protected

  def reactable
    'likable'
  end

  def react_class
    ::Feed::Like
  end
end
