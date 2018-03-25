module Tweets::RepliesHelper
  def replyable_path(replyable)
    classes = ["Tweet::Reply", "Tweet::ReplyDecorator"]
    if classes.include?(replyable.class.name)
      reply_replies_path(replyable)
    else
      tweet_replies_path(replyable)
    end
  end
end
