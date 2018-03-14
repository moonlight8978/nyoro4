class Users::Settings::AccountsController < Devise::RegistrationsController
  layout 'setting'

  before_action :configure_account_update_params, only: [:update]

  # def edit
  #   super
  # end
  #
  # def update
  #   super
  # end

  # def destroy
  #   super
  # end

protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username, :profilename, :avatar, :cover, :birthday, :birthday_visibility,
      :country, :language
    ])
  end

  def after_update_path_for(resource)
    edit_user_settings_account_path
  end
end
