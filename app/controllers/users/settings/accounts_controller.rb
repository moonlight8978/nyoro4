class Users::Settings::AccountsController < Devise::RegistrationsController
  layout 'setting'

  before_action :configure_account_update_params, only: [:update]

  # Return view to edit profile
  def edit
    super
  end

  # Save profile changes
  def update
    super
  end

  # Deactive account
  def destroy
    super
  end

protected

  # User can update information without providing current password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # Attributes user can change without password
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username, :profilename, :avatar, :cover, :birthday, :birthday_visibility,
      :country, :language
    ])
  end

  # Redirect to change profile page after saving changes
  def after_update_path_for(resource)
    edit_user_settings_account_path
  end
end
