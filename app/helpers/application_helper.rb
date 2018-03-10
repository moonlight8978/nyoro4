module ApplicationHelper
  def show_errors(model, attribute)
    if model.errors.messages[attribute].any?
      content_tag :div, model.errors.messages[attribute].join(". "), class: "form-errors mt-1"
    end
  end

  def flash_errors
    if flash.any?
      messages = flash.map { |_name, message| message }
      content_tag :div, messages.join(". "), class: "form-errors mt-1"
    end
  end
end
