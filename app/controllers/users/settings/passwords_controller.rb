class Users::Settings::PasswordsController < Devise::RegistrationsController
  layout 'setting'

  # def edit
  #   super
  # end
  #
  # def update
  #   super
  # end

  def after_update_path_for(resource)
    edit_user_settings_password_path
  end
end
