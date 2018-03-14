module Users::Settings::AccountsHelper
  def settings_account_path?
    current_page?(controller: "users/settings/accounts", action: :edit) ||
    current_page?(controller: "users/settings/accounts", action: :update)
  end
end
