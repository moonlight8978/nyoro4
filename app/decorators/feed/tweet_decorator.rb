class Feed::TweetDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user, with: UserDecorator

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def content
    Nyoro::Text::Autolink.auto_link(h.html_escape(object.content))
  end

  # Relative time from created time
  def created_at
    from = object.created_at
    distance_in_seconds = (Time.now - from).round
    if distance_in_seconds.between?(0, 24 * 60 * 60 - 1)
      h.time_ago_in_words(from)
    else
      h.l(from, format: :short)
    end
  end
end
