class ReplyService::Destroy
  # Return service object to delete reply
  def initialize(reply)
    @reply = reply
    @tweet = reply.tweet
  end

  # Delete the comment and related associations
  def perform
    ActiveRecord::Base.transaction do
      reply.update(deleted: true)
      reply.taggings.delete_all
      reply.mentionings.delete_all
    end
  end

private

  attr_reader :reply, :tweet
end
