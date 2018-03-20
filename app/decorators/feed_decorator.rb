class FeedDecorator < ApplicationDecorator
  delegate_all

  decorates_association :tweet, with: Feed::TweetDecorator, context: {}

  # Path to component in views folder
  COMPONENT_PATH = "components/feed/index"

  RETWEET_ICON_CLASS = "fas fa-retweet"
  LIKE_ICON_CLASS = "fas fa-heart"
  TWEET_CONTAINER_CLASS = "tweet-container"
  THREAD_CONTAINER_CLASS = "tweet-container thread"

  CONTEXT = {
    retweet_class: RETWEET_ICON_CLASS,
    like_class: LIKE_ICON_CLASS,
    retweet_text: -> (profilename) { h.t(:retweet, scope: "views.context", profilename: profilename) },
    like_text: -> (profilename) { h.t(:like, scope: "views.context", profilename: profilename) },
  }

  CONTAINER = {
    tweet_class: TWEET_CONTAINER_CLASS,
    thread_class: THREAD_CONTAINER_CLASS,
  }

  def container_class
    if thread?
      CONTAINER[:thread_class]
    else
      CONTAINER[:tweet_class]
    end
  end

  # Feed context
  def context
    if like?
    elsif retweet?
    else
      nil
    end
  end

  # Feed tweet
  def original_tweet
    tweet =
      if like?
      elsif retweet?
      else
        self.tweet
      end
    h.render partial: "components/tweet/index", object: tweet, as: :tweet
  end

  # Feed thread extras
  def extras
    nil
  end

  def render(options = {})
    params = {
      partial: "components/feed/index",
      object: self, as: :feed
    }.merge(options)
    h.render params
  end
end
