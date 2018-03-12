class Users::Settings::AccountsController < Devise::RegistrationsController
  layout 'setting'

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
end
