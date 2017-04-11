class Collaborator < ActiveRecord::Base
  def self.wikis
    Wiki.where( id: pluck(:wiki_id))
  end

  def self.users
    User.where( id: pluck(:user_id))
  end

  def wikis
    Wiki.find(wiki_id)
  end

  def users
    User.find(user_id)
  end
end
