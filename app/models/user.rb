class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         :encryptable,
         :encryptor => :sha512,
         :confirm_within => 30.years
        
  has_many :authentications, :dependent => :destroy, :autosave => true, :validate => false

  field :name
  field :login
  field :email
  field :password

  def saved_or_unsaved_authentication_for(provider)
    self.authentications.detect {|a| a.provider == provider }
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
