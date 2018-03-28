class FeedDecorator < ApplicationDecorator
  delegate_all

  decorates_association :tweet, with: Feed::TweetDecorator, context: {}

  # Path to component in views folder
  COMPONENT_PATH = "components/feed"

  RETWEET_ICON_CLASS = "fas fa-retweet"
  LIKE_ICON_CLASS = "fas fa-heart"
  TWEET_CONTAINER_CLASS = "tweet-container"
  THREAD_CONTAINER_CLASS = "tweet-container thread"

  CONTEXT = {
    retweet_icon: RETWEET_ICON_CLASS,
    like_icon: LIKE_ICON_CLASS,
    retweet_text: -> (profilename, username) { h.t(:retweeted, scope: "views.context", profilename: profilename, username: username) },
    like_text: -> (profilename, username) { h.t(:liked, scope: "views.context", profilename: profilename, username: username) },
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
      h.render partial: 'components/tweets/context', locals: { user: object.like.user, context: CONTEXT[:like_text].call(object.like.user.profilename, object.like.user.username), icon: CONTEXT[:like_icon] }
    elsif retweet?
      h.render partial: 'components/tweets/context', locals: { user: object.retweet.user, context: CONTEXT[:retweet_text].call(object.retweet.user.profilename, object.retweet.user.username),
      icon: CONTEXT[:retweet_icon] }
    else
      nil
    end
  end

  # Feed tweet
  def original_tweet
    if like?
      object.like.tweet
    elsif retweet?
      object.retweet.tweet
    else
      self.tweet
    end
  end

  # Feed thread extras
  def extras
    nil
  end
end
