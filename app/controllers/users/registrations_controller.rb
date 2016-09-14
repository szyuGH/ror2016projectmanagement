class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_params, if: :devise_controller?

  protected

    def configure_permitted_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:login, :first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:login, :first_name, :last_name])
    end
end
