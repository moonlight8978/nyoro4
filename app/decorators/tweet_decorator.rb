module TweetDecorator
  extend ActiveSupport::Concern

  included do
    include ::Tweet::MediaDecorator

    delegate_all

    decorates_association :user, with: ::UserDecorator

    # Auto-links #hashtags, @usernames and urls
    def content
      Nyoro::Text::Autolink.auto_link(h.html_escape(object.content))
    end

    # Relative time from the time created
    def created_at
      from = object.created_at
      distance_in_seconds = (Time.now - from).round
      p from.to_datetime.to_date
      if distance_in_seconds.between?(0, 24 * 60 * 60 - 1)
        h.time_ago_in_words(from)
      else
        h.l(from.to_datetime.to_date, format: :short)
      end
    end

    # Created time in long format
    def created_at_long
      h.l(object.created_at, format: :long)
    end

    # Render reply, retweet, and like button for tweet
    def action_buttons(reply_js = true)
      reply_classnames = ['tweet-action-button', 'btn-action-reply']
      reply_classnames.push('js-btn-reply-tweet') if reply_js
      reply_classnames = reply_classnames.join(' ')

      retweet_classnames = ['tweet-action-button', 'btn-action-retweet', 'js-btn-react']
      retweet_classnames.push('btn-undo') if self.retweeted?
      retweet_classnames = retweet_classnames.join(' ')

      like_classnames = ['tweet-action-button', 'btn-action-favorite', 'js-btn-react']
      like_classnames.push('btn-undo') if self.liked?
      like_classnames = like_classnames.join(' ')

      classnames = {
        reply: reply_classnames,
        retweet: retweet_classnames,
        like: like_classnames,
      }

      urls = {
        reply: reply_path,
        retweet: retweet_path,
        like: like_path,
      }

      h.render partial: "components/tweets/actions",
        locals: { tweet: self, classnames: classnames, urls: urls }
    end

    # Content which is visible for owner
    def for_owner(&block)
      if h.can? :crud, object
        h.capture(&block)
      end
    end

    # Content which is visible for other people
    def for_others(&block)
      if h.can? :report, object
        h.capture(&block)
      end
    end

    # Render optional actions dropdown
    def options_dropdown
      h.render partial: 'components/tweets/options', locals: { tweet: self }
    end

    def destroy_path
      raise NoMethodError
    end
  end
end
