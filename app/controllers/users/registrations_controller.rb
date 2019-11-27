# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    params.require(:user).permit(:enterprise_name, :email, :password, :password_confirmation)
  end
end
