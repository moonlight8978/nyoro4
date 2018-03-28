class ReplyService::Tweet::Create
  attr_reader :reply

  # Return service object
  # @param reply    [Tweet::Reply] the reply user made
  # @param reply_to [Feed::Tweet]  the tweet which current user is going
  #   to reply to
  # @param user     [User]         current user
  def initialize(reply, reply_to, user)
    @reply = reply
    @reply_to = reply_to
    @user = user
  end

  # Save the reply
  def perform
    ActiveRecord::Base.transaction do
      reply.save
      Feed::Tweet.increment_counter(:replies_count, reply_to.id)
    end
  end

private

  attr_reader :user, :reply_to
end
