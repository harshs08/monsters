class Team < ActiveRecord::Base
  LIMIT = 3
  belongs_to :user
  has_many :monsters, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :status
  validate :teams_limit, on: :create
  validates_uniqueness_of :name

  private
    def teams_limit
      if self.user.teams(:reload).count >= LIMIT
        errors.add(:base, "Exceeded teams limit for the user.")
      end
    end
end
