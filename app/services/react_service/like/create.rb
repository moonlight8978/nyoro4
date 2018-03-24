class ReactService::Like::Create
  include ::ReactService::Create

protected

  def react_class
    ::Feed::Like
  end

  def reactable
    'likable'
  end
end
