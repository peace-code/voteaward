class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  has_one :promise
  has_one :giveup
  has_many :votes
  has_many :awards
  has_many :campaigns
  has_many :events
  has_many :comments

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
      :rememberable, :trackable, :validatable,
      :omniauthable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  def email_required?
    false
  end

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  ## Sns
  field :omniauth_provider
  field :omniauth_uid
  field :omniauth_credentials
  field :omniauth_url

  # methods
  def admin?
    %w[rest515@gmail.com dangun76@gmail.com].include?(email)
  end

  def profile_image
    if omniauth_provider == :facebook
      "http://graph.facebook.com/#{omniauth_uid}/picture?type=large"
    else
      omniauth_image
    end
  end

  def twitter
    @twitter ||= Twitter::Client.new(
      oauth_token: omniauth_credentials['token'],
      oauth_token_secret: omniauth_credentials['secret']
    )
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(omniauth_credentials['token'])
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end
end