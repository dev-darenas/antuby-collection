class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    if current_user.update(
        google_refresh_token: request.env['omniauth.auth'].credentials.token,
        google_token: request.env['omniauth.auth'].credentials.refresh_token
      )
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      redirect_to edit_user_path(current_user)
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to edit_user_path(current_user), alert: "Error"
    end
  end
end
