class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider
  field :uid
  field :token
  field :secret
  field :oauth_verifier  # Used by LinkedIn only so far.

  belongs_to :user

  scope :with_provider_and_uid, lambda { |provider, uid| where(:provider => provider, :uid => uid) }

  class << self
    def find_user(auth)
      authentication = with_provider_and_uid(auth['provider'], auth['uid']).first and return authentication.user
      nil
    end
  end
end
