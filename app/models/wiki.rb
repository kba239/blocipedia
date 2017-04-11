class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :visible_to, -> (user) { user ? where(private: false) : 'There was an error.' }

  def make_public
    update_attribute(private: false)
  end

  def public?
    !private?
  end

  def private?
    !!self.private 
  end

end
