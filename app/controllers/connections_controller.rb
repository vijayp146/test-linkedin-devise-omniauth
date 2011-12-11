class ConnectionsController < ApplicationController
  def show
    authentication = current_user.authentications.first
    @linked_in_client = LinkedIn::Client.new(Mong::Application.config.linkedin_key, Mong::Application.config.linkedin_secret)
    @linked_in_client.authorize_from_access(authentication.token, authentication.secret)
    @linked_in_client
  end
end
