class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable


  before_save { self.role ||= :standard }

  # validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  #
  # validates :email,
  #           presence: true,
  #           uniqueness: { case_sensitive: false },
  #           length: { minimum: 3, maximum: 254 }
  # validates :password, presence: true, length: { minimum: 6 }
  # validates :password, length: { minimum: 6 }, allow_blank: true

  #has_secure_password

  enum role: [:standard, :premium, :admin]
end
