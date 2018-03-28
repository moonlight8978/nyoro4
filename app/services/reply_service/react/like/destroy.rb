class ReplyService::React::Like::Destroy
  include ::ReplyService::React::Destroy

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
