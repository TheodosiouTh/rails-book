class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :require_login, :get_pending


    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name,:last_name, :email, :password, :provider, :uid)}
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :image, :email, :password, :current_password, :provider, :uid)}
        end

    private
        def require_login
            if current_user.nil? && !['/signup', '/login','/users','/users/sign_in','/users/sign_up','/users/password/new'].include?(request.fullpath)
                redirect_to '/login'
            end
        end

        def get_pending
            if !current_user.nil?
                @pending = current_user.incomming.where(accepted: false)
                #get newer pending friend requests first
                if !@pending.nil?
                    @pending = @pending.order(created_at: :desc)
                end
            end
        end
end
