module MonstersHelper
  def monster_team
    monster = Monster.find(params[:id])
    @monster_team = Team.where("status = ? AND id = ?", 'manual', monster.team_id).first
  end
end
