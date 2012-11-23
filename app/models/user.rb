class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  mount_uploader :avatar, AvatarUploader
  process_in_background :avatar
  store_in_background :avatar

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :avatar, :avatar_cache, :remove_avatar, :facebook_token, :facebook_expires_at
  # attr_accessible :title, :body
  has_many :wines


  def has_permission?(subject)
    subject.try(:user).try(:id) == self.id
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(facebook_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

  def post_to_facebook(url)
    facebook.put_connections("me", "itastetw:taste", wine: url)
  end

  def self.from_omniauth(auth)
    user = where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.email = auth.info.email
    end
    user.facebook_token = auth.credentials.token
    user.facebook_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create an user with a stub password.
      user = User.new(:email => data["email"], :password => Devise.friendly_token[0,20],  :agreement_status => true)
      user.confirm!
      user.save!
      user
    end
  end

end
