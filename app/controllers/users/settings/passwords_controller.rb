class Users::Settings::PasswordsController < Devise::RegistrationsController
  layout 'setting'

  # Returns view to change password
  def edit
    super
  end

  # Save new password
  def update
    super
  end

protected

  # Redirect user to change password page after saving new password
  def after_update_path_for(resource)
    edit_user_settings_password_path
  end
end
