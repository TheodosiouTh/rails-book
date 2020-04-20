class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :require_login



    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name,:last_name, :email, :password)}

            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password)}
        end

    private
        def require_login
            if current_user.nil? && !['/users/sign_up', '/users/sign_in'].include?(request.fullpath)
                redirect_to '/users/sign_in'
            end
        end
end
