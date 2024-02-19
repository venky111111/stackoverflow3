class OmniauthController < ApplicationController
	def github
      @user = User.create_from_provider_data(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in_and_redirect @user
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: "Github"
      else
        flash[:notice] = 'There was a problem signing you in through Github. Please register or try signing in later.'
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end
 
    def google_oauth2
      @user = User.create_from_provider_data(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in_and_redirect @user
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: "Google"
      else
        

        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
 
    end
 
    def failure
      flash[:notice] = 'There was a problem signing you in. Please register or try signing in later.'
      redirect_to new_user_registration_url
  end

end
