# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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


  before_action :customer_state, only: [:create]

def after_sign_in_path_for(resource)
    root_path
end


  protected

  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


    def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == "退会"
      redirect_to new_customer_registration_path
    #else
    end
    end

end