module ReplyService::React::Create
  # TODO: Refactoring
  def initialize(reply, reactor)
    @reply = reply
    @reactor = reactor
  end

  def perform
    ActiveRecord::Base.transaction do
      react_class
        .create(user: reactor, "#{reactable}": reply)
      Tweet::Reply.increment_counter(:"#{counter_column}", reply.id)
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

  def counter_column
    raise NoMethodError
  end
end
