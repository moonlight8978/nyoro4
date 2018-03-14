module Users::Settings::PasswordsHelper
  def settings_password_path?
    current_page?(controller: "users/settings/passwords", action: :edit) ||
    current_page?(controller: "users/settings/passwords", action: :update)
  end
end
