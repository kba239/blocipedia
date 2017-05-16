class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable


  before_create { self.role ||= :standard }

  has_many :wikis, dependent: :destroy
  has_many :collaborations
  has_many :collaborating_wikis, through: :collaborations, source: :wiki


  enum role: [:standard, :premium, :admin]

  def downgrade
    self.role = :standard

    wikis.each { |wiki| wiki.make_public }


    self.save

  end

end
