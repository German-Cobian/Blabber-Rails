class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :conversations, dependent: :destroy
  has_many :messages
  
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  #password is validated only upon creation
  with_options presence: true do
    validates :password, on: :create
  end

  enum is_enabled: { disabled: false, enabled: true }
  enum role: %i[user admin]

  def set_default_role
    self.role ||= :user
  end
end
