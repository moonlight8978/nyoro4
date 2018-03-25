module ReplyService::React::Destroy
  # TODO: Refactoring
  def initialize(reply, reactor)
    @reply = reply
    @reactor = reactor
  end

  def perform
    ActiveRecord::Base.transaction do
      react_class
        .find_by(user: reactor, "#{reactable}": reply)
        .destroy
    end
  end

protected

  attr_reader :reactor, :reply

  def react_class
    raise NoMethodError
  end

  def reactable
    raise NoMethodError
  end
end
