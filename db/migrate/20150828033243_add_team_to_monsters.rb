class AddTeamToMonsters < ActiveRecord::Migration
  def change
    add_reference :monsters, :team, index: true, foreign_key: true
  end
end
