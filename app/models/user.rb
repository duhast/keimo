class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::Followable

  devise :database_authenticatable, :registerable,:trackable, :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :name, type: String
  field :title, type: String
  field :avatar_url, type: String

  has_many :questions
  has_many :answers

  validates :name, presence: true
  validates :title, presence: true



end
