class Account
  include DataMapper::Resource
  include DataMapper::Validate
  attr_accessor :password, :password_confirmation

  # Properties
  property :id,               Serial
  property :name,             String
  property :surname,          String
  property :email,            String
  property :crypted_password, String, :length => 70
  property :role,             String
  property :uid,              String
  property :provider,         String
  property :link,             String
  property :gender,           String
  property :picture,          String
  property :token,            String
  property :nickname,         String
  property :address,          String
  property :telephone,        String
  property :address_detail,   Text
  


  # Validations
  validates_presence_of      :email, :role
  validates_presence_of      :password,                          :if => :password_required
  validates_presence_of      :password_confirmation,             :if => :password_required
  validates_length_of        :password, :min => 4, :max => 40,   :if => :password_required
  validates_confirmation_of  :password,                          :if => :password_required
  validates_length_of        :email,    :min => 3, :max => 100
  validates_uniqueness_of    :email,    :case_sensitive => false
  validates_format_of        :email,    :with => :email_address
  validates_format_of        :role,     :with => /[A-Za-z]/

  # Callbacks
  before :save, :encrypt_password

  ##
  # This method is for authentication purpose
  #
  def self.authenticate(email, password)
    account = first(:conditions => { :email => email }) if email.present?
    account && account.has_password?(password) ? account : nil
  end

  ##
  # This method is used by AuthenticationHelper
  #
  def self.find_by_id(id)
    get(id) rescue nil
  end

  def self.find_uid(uid)
    Account.first(:uid=>uid)
  end

  def self.new_from_omniauth(omniauth, provider = 'facebook')

    user          = Account.find_by_email(omniauth["info"]["email"])
    user          = Account.new if user.blank?

    user.uid      = omniauth["uid"]
    user.nickname = omniauth["info"]["nickname"]
    user.name     = omniauth["info"]["first_name"]
    user.surname  = omniauth["info"]["last_name"]
    user.email    = omniauth["info"]["email"]
    user.provider = provider
    user.link     = omniauth["info"]["urls"]["Facebook"]
    user.gender   = omniauth["extra"]["raw_info"]["gender"]
    user.picture  = omniauth["info"]["image"]
    user.token    = omniauth["credentials"]["token"]

    if user.new?
      user.role     = "user"
    end
    user.save!
    
    user
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  def nombre
    "#{name} #{surname}"
  end


  private
  def password_required
    crypted_password.blank? || password.present?
  end

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password) if password.present?
  end
end
