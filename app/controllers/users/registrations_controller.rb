class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_params, if: :devise_controller?

  protected

    def configure_permitted_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name, :email])
    end
end
