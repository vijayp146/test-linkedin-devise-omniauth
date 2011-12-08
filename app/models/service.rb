class Service
  class << self
    def apply_auth(user, auth)
      authentication   = user.saved_or_unsaved_authentication_for(auth['provider'])
      authentication ||= user.authentications.build(:provider => auth['provider'], :uid => auth['uid'], :oauth_verifier => auth['oauth_verifier'])

      authentication.token  = auth['credentials']['token']
      authentication.secret = auth['credentials']['secret']

      user.login = auth['info']['name']
      user.email = "somethingbogus#{rand(1000)}@example.com"
      
      user.skip_confirmation!

      user
    end
  end
end
