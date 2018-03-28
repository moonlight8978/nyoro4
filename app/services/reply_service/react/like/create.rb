class ReplyService::React::Like::Create
  include ::ReplyService::React::Create

protected

  def reactable
    'likable'
  end

  def react_class
    ::Feed::Like
  end

  def counter_column
    'likes_count'
  end
end
