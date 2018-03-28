class ReactService::Like::Create
  include ::ReactService::Create

protected

  def react_class
    ::Feed::Like
  end

  def reactable
    'likable'
  end

  def counter_column
    'likes_count'
  end
end
