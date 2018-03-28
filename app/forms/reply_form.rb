class ReplyForm < ApplicationForm
  delegate :content, :root, :root_id, :previous_id, :user_id, :tweet_id,
    :photos, :video, :content, to: :reply

  validates :content, presence: true
  validates :user, presence: true
  validates :tweet, presence: true
  validate :max_photos

  attr_accessor :params, :tweet, :previous, :user, :reply

  MAX_PHOTO = 3

  # Build tweet's reply
  def self.from_tweet(tweet, user, params)
    form = self.new(tweet: tweet, user: user, params: params)
    form.tap do |f|
      f.reply.tweet_id = tweet.id
    end
  end

  # Build subreply (reply's reply)
  def self.from_reply(reply, user, params)
    form = self.new(previous: reply, user: user, params: params)
    form.tap do |f|
      f.tweet = reply.tweet
      f.reply.assign_attributes(
        previous_id: reply.id,
        tweet_id: reply.tweet_id,
        root_id: reply.root_id || reply.id
      )
    end
  end

  # Return the reply
  def reply
    return @reply if @reply
    @reply = Tweet::Reply.new(reply_params)
    @reply.tap do |r|
      r.user_id = user.id
    end
  end

private
  # Permit strong parameters
  def reply_params
    params.require(:reply).permit(
      :content, :video, photos: []
    )
  end

  # User can't upload more than 3 photos
  def max_photos
    if photos.size > MAX_PHOTO
      errors.add(:photos, :too_many)
    end
  end
end
