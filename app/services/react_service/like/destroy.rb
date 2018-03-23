class ReactService::Like::Destroy
  include ::ReactService::Destroy

  def react_class
    ::Feed::Like
  end
end
