class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable


  before_create { self.role ||= :standard }

  has_many :wikis, dependent: :destroy


  enum role: [:standard, :premium, :admin]

  def downgrade
    self.role = :standard

    wikis.each { |wiki| wiki.make_public }


    self.save

  end

  def collaborators
     Collaborator.where(user_id: id)
   end

   def wikis
     Wiki.where( id: collaborators.pluck(:wiki_id) )
   end

end
