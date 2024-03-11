# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   before_action :user_state, only: [:create]

    private
    
    def user_state
      user = User.find_by(email: params[:user][:email])  
      return if user.nil?
      return unless user.valid_password?(params[:user][:password])
      
        if user.is_active
         return
        else

          redirect_to  new_user_registration_path

        end
      
    end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
    def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to user_path(user), notice: "ゲストでログインしました。"
    end
  
    def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email] [:passsword])
    end

   def after_sign_in_path_for(resource)

     user_path(current_user)

   end

   def after_sign_out_path_for(resource)

    root_path

   end
   
end
