class AddStatusToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :status, :string, default: 'default'
  end
end
