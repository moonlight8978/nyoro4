module Feeds::TweetsHelper
  def tweet_action_class_name(type, js = true)
    class_names = ["tweet-action-button", "btn-action-#{type}"]
    class_names << "js-btn-#{type}-tweet" if js
    class_names.join(' ')
  end
end
