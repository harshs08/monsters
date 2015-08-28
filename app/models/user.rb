class User < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  has_many :monsters, through: :teams, dependent: :destroy
  validates_presence_of :name

  class << self
    def from_omniauth(auth_hash)
      user           = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name      = auth_hash['info']['name']
      user.location  = auth_hash['info']['location']
      user.image_url = auth_hash['info']['image']
      user.url       = auth_hash['info']['urls'][user.provider.capitalize]
      user.save!
      if user.teams.blank?
         user.teams.create(name: "#{user.id}_team", status: "default")
       end 
      user      
    end
  end
end
