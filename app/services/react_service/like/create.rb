class ReactService::Like::Create
  include ::ReactService::Create

  def react_class
    ::Feed::Like
  end
end
