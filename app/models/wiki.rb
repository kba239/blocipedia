class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :visible_to, -> (user) { user ? where(private: false) : 'There was an error.' }

  def make_public
    # if user.downgrade
    #   wikis == public
    # end
    where(private: true).each do |public|
      public.update_attribute(private: false)
    end
  end

end
