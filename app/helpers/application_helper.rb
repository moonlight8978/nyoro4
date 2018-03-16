module ApplicationHelper
  def show_errors(model, attribute)
    if model.errors.messages[attribute].any?
      content_tag :div, model.errors.messages[attribute].join(". "), class: "form-errors mt-1"
    end
  end

  def flash_errors
    if alert
      content_tag :div, alert, class: "form-errors mt-1"
    end
  end

  def flash_info
    if notice
      content_tag :div, notice, class: "alert alert-info", role: "alert"
    end
  end

  def current_language
    case I18n.locale
    when :en
      "English"
    when :ja
      "日本語"
    when :vi
      "Tiếng Việt"
    end
  end

  def class_names(*classes, condition_classes)
    classes
    condition_classes.each do |css_class, condition|
      classes.push(css_class) if condition
    end
    classes.join(" ")
  end

  # @param user [User] User to render
  # @param [Hash]
  # @option include_extras [Boolean] Render with extra informartions
  # @option style [Integer] Choose box style, default is 1
  def render_profile_summary_box(user, **options)
    options[:style] = 1 unless options[:style]
    partial = "components/profile_summary/style_#{options[:style]}"

    render partial: partial, locals: options.merge(user: user)
  end

  def render_footer_box
    render 'components/footer/index'
  end

  def render_follow_suggestions_box
    suggestions = User.suggestions_for(current_user)
    render partial: 'components/follow_suggestions/index',
      locals: { users: suggestions }
  end

  def render_tweet(tweet)
    render partial: 'components/tweet/index', locals: { tweet: tweet }
  end

  def follow_buttons_for(user, following = false)
    state = following ? "following" : "follow"
    container_class_names = ["follow-container-js", state].join(" ")
    html = link_to(
      t(:follow, scope: 'views.users.shared'),
      users_followings_path(user.id),
      class: "btn btn-edge--small btn-edge btn-secondary btn-follow",
      "data-type": :post
    )
    html << link_to(
      t(:following, scope: 'views.users.shared'),
      users_followings_path(user.id),
      class: "btn btn-edge--small btn-edge btn-primary btn-following",
      "data-type": :delete
    )
    content_tag :div, html, class: container_class_names
  end

  # @param [Hash] Arguments
  # @option src [String] Path to image
  # @option ratio [String] Image ratio like 1_1, 3_1, 2_3, etc...
  # @option avatar [Boolean] if avatar
  def render_image(**args)
    src = args[:src]
    ratio = args[:ratio]
    avatar = !!args[:avatar]
    img_class_names = avatar ? "img-thumb avatar-thumb" : "img-thumb"

    content_tag :div, class: "img-placeholder ratio-#{ratio}" do
      image_tag src, class: img_class_names
    end
  end

  def user_names_multilines(user = current_user, action = true)
    profilename_html = link_to_if action, content_tag(:strong, user.profilename), profile_path(user.username) do
      content_tag(:strong, user.profilename)
    end
    username_html = link_to_if action, content_tag(:span, "@#{user.username}"), profile_path(user.username) do
      content_tag(:span, "@#{user.username}")
    end

    content_tag :div, class: "account-names ellipsis" do
      profilename_html + username_html
    end
  end

  def user_names_singleline(user = current_user)
    content_tag :div, class: "account-info ellipsis" do
      link_to profile_path(user.username), class: "account-link" do
        html = content_tag(:strong, user.profilename)
        html << content_tag(:span, "&nbsp;".html_safe)
        html << content_tag(:span, "@#{user.username}")
      end
    end
  end

  def current_user?(user)
    current_user == user
  end
end
