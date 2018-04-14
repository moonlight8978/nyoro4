module TweetService
  # Use to delete tweet
  class Destroy
    # @param tweet [Feed::Tweet] Tweet need to delete
    def initialize(tweet)
      @tweet = tweet
    end

    # Perform the service
    def perform
      retweets = Feed::Retweet.reacted_to(tweet)
      likeds = Feed::Like.reacted_to(tweet)
      reply_ids = Tweet::Reply.where(tweet: tweet)
      
      ActiveRecord::Base.transaction do
        retweets.delete_all
        likeds.delete_all

        Feed::Retweet.where(retweetable_id: reply_ids, retweetable_type: 'Tweet::Reply').delete_all
        Feed::Like.where(likable_id: reply_ids, likable_type: 'Tweet::Reply').delete_all
        Tweet::Mentioning.where(mentionable_id: reply_ids, mentionable_type: 'Tweet::Reply').delete_all
        Tweet::Tagging.where(taggable_id: reply_ids, taggable_type: 'Tweet::Reply').delete_all
        Tweet::Reply.where(id: reply_ids).delete_all

        tweet.mentionings.delete_all
        tweet.taggings.delete_all
        tweet.destroy
      end
    end

  private

    attr_reader :tweet
  end
end
