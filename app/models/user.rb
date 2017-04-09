class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable


  before_save { self.role ||= :standard }

  has_many :wikis, dependent: :destroy


  enum role: [:standard, :premium, :admin]

  def downgrade
    role = 'standard'

    wikis.each { |wiki| wiki.make_public }
    

    save

  end

end
