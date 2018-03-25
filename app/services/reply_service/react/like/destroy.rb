class ReplyService::React::Like::Destroy
  include ::ReplyService::React::Destroy

protected

  def reactable
    'likable'
  end

  def react_class
    ::Feed::Like
  end
end
