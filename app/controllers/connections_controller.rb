class ConnectionsController < ApplicationController
  def show
    authentication = current_user.authentications.first
    @linked_in_client = LinkedIn::Client.new(Mong::Application.config.linkedin_key, Mong::Application.config.linkedin_secret)
    
    # It crashes here.
    @linked_in_client.authorize_from_request(@linked_in_client.request_token.token, @linked_in_client.request_token.secret, authentication.oauth_verifier)
    @linked_in_client
  end
end
