class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def method_missing(provider)
    auth = env["omniauth.auth"].merge('oauth_verifier' => params['oauth_verifier'])

    user   = current_user
    user ||= Authentication.where(:provider => auth['provider'], :uid => auth['uid']).first.try(:user)
    user ||= User.new
    
    if authentication = user.authentications.where(:provider => auth['provider']).first
      sign_in_and_redirect(:user, user)
    else
      user = Service.apply_auth(user, auth)
      user.save!
      sign_in_and_redirect(:user, user)
    end
  end
end
