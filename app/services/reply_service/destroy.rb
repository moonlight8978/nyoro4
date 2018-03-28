class ReplyService::Destroy
  # Return service object to delete reply
  def initialize(reply)
    @reply = reply
    @tweet = reply.tweet
  end

  # Delete the comment and related associations
  def perform
    reply.update(deleted: true)
  end

private

  attr_reader :reply, :tweet
end
