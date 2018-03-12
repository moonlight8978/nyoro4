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
end
