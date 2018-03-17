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

  def render_footer_box
    render 'components/footer/index'
  end

  def render_follow_suggestions_box
    suggestions = User.suggestions_for(current_user).decorate
    render partial: 'components/follow_suggestions/index', locals: { suggestions: suggestions }
  end

  def render_tweet(tweet)
    render partial: 'components/tweet/index', locals: { tweet: tweet }
  end

  # Return image with placeholder container
  # @param src [String]     path to image
  # @param ratio [String]   image ratio. `1_1`, `3_1`, `2_3`, etc...
  # @param avatar [Boolean] if avatar
  def image_container(src, ratio, avatar = false)
    img_class_names = avatar ? "img-thumb avatar-thumb" : "img-thumb"

    content_tag :div, class: "img-placeholder ratio-#{ratio}" do
      image_tag src, class: img_class_names
    end
  end
end
