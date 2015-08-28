class Monster < ActiveRecord::Base
  LIMIT1 = 20
  LIMIT2 = 3
  belongs_to :team
  self.inheritance_column = nil
  validates_inclusion_of :type, in: MosterType.pluck(:name)
  validate :monsters_limit, on: :create
  validate :validate_team_size, on: [:create, :update]
  validates_presence_of :name
  validates_presence_of :power
  validates_presence_of :type
  validates_uniqueness_of :name

  private
    def monsters_limit
      if self.team.user.monsters(:reload).count > LIMIT1
        errors.add(:base, "Exceeded monsters limit for the user.")
      end
    end

    def validate_team_size
      @user_team = self.team(:reload)
      if Team.where(id: @user_team.id).where.not(status: 'default').count > LIMIT2
        errors.add(:base, "Exceeded monsters limit in a team.")
      end
    end

end
