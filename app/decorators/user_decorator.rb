class UserDecorator < ApplicationDecorator
  delegate_all
  # CSS class for follow link
  FOLLOW_BUTTON_CLASS = "btn btn-edge--small btn-edge btn-secondary btn-follow".freeze
  # CSS class for unfollow link
  FOLLOWING_BUTTON_CLASS = "btn btn-edge--small btn-edge btn-primary btn-following".freeze
  # Follow container CSS class
  FOLLOW_CONTAINER_CLASS = "js-follow-container follow-container".freeze

  FOLLOWINGS = {
    follow_class: FOLLOW_BUTTON_CLASS,
    following_class: FOLLOWING_BUTTON_CLASS,
    container_class: FOLLOW_CONTAINER_CLASS,
  }

  # CSS class for names multilines container
  NAMES_MULTI_CONTAINER_CLASS = "account-names ellipsis".freeze
  # CSS class for names singleline container
  NAMES_SINGLE_CONTAINER_CLASS = 'account-info ellipsis'.freeze
  # CSS class for name link
  NAME_LINK_CLASS = "account-link".freeze

  NAMES = {
    multi_container_class: NAMES_MULTI_CONTAINER_CLASS,
    single_container_class: NAMES_SINGLE_CONTAINER_CLASS,
    link_class: NAME_LINK_CLASS,
  }

  # Generate follow buttons group
  def follow_buttons
    current_user_following_ids = h.current_user.following_ids
    following = current_user_following_ids.include?(object.id)
    state = following ? "following" : "follow"
    container_class_names = [FOLLOWINGS[:container_class], state].join(" ")

    html = link_to_follow(:post, :follow)
    html << link_to_follow(:delete, :following)
    h.content_tag :div, html, class: container_class_names
  end

  # Generate group of username and profilename in seperate lines
  #
  # @param with_url [Boolean] profilename and @username will be links
  def names_multilines(with_url = false)
    profilename_html = h.link_to_if with_url, h.content_tag(:strong, object.profilename), profile_path do
      h.content_tag(:strong, object.profilename)
    end
    username_html = h.link_to_if with_url, h.content_tag(:span, username_with_symbol), profile_path do
      h.content_tag(:span, username_with_symbol)
    end

    h.content_tag :div, class: NAMES[:multi_container_class] do
      profilename_html << username_html
    end
  end

  # Generate group of username and profilename in single line
  def names_singleline
    group =
      h.link_to profile_path, class: NAMES[:link_class] do
        html = h.content_tag(:strong, object.profilename)
        html << h.content_tag(:span, Nyoro::Text.html_map(:space))
        html << h.content_tag(:span, username_with_symbol)
      end
    h.content_tag :div, group, class: NAMES[:single_container_class]
  end

  # Check if current_user
  #
  # @return [Boolean]
  def current_user?
    h.current_user == object
  end

  # Render profile summary box
  #
  # @param style [Integer] Box style, currently supports 1, and 2
  # @param [Hash] options Box options
  # @option options [Boolean] :include_extras Extra informations, only supports style 1
  def profile_summary_box(style, options = {})
    partial = "components/profile_summary/style_#{style}"

    h.render partial: partial, object: self, as: :user, locals: options
  end

  # Add auto-link urls, hashtags, usernames
  def introduction
    Nyoro::Text::Autolink.auto_link(h.html_escape(object.introduction))
  end

private

  # Link to follow or unfollow user
  #
  # @param method [Symbol] HTTP method for link, `:delete` or `:post`
  # @param type [Symbol] Type of link, `:follow` or `:following`
  def link_to_follow(method, type)
    h.link_to(
      h.t(type, scope: 'views.users.shared'),
      followings_path,
      class: FOLLOWINGS[:"#{type}_class"],
      "data-http": method
    )
  end

  # Return path to follow/unfollow
  def followings_path
    h.users_followings_path(object.id)
  end

  # Return path to profile
  def profile_path
    h.profile_path(object.username)
  end

  # Return username with symbol @
  def username_with_symbol
    "@#{object.username}"
  end
end
