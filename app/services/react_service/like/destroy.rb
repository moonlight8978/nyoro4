class ReactService::Like::Destroy
  include ::ReactService::Destroy

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
