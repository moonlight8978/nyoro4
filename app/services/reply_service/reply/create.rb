# Service use to create reply's reply
class ReplyService::Reply::Create
  attr_reader :reply

  # Return service object
  # @param reply    [Tweet::Reply] the reply user made
  # @param reply_to [Tweet::Reply] the reply which current user is going
  #   to reply to
  # @param user     [User]         current user
  def initialize(reply, reply_to, user)
    @reply = reply
    @reply_to = reply_to
    @user = user
    @tweet = @reply_to.tweet
  end

  # Save the reply
  def perform
    hashtags = reply.extract_hashtags
    users = reply.extract_mentioned_users

    ActiveRecord::Base.transaction do
      reply.save
      Tweet::Reply.increment_counter(:replies_count, reply_to.id)
      Feed::Tweet.increment_counter(:replies_count, tweet.id)
      hashtags.map do |name|
        hashtag = ::Tweet::Hashtag.find_or_create_by(name: name)
        tagging = ::Tweet::Tagging.create(hashtag: hashtag, taggable: reply)
      end
      users.map do |user|
        mentioning = ::Tweet::Mentioning.create(mentionable: reply, user: user)
      end
    end
  end

private

  attr_reader :user, :reply_to, :tweet
end
