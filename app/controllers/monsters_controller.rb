class MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @user     = User.find_by(id: params['user_id'])
    if sort_column == 'type'
      @monsters = @user.monsters.select("monsters.*, moster_types.rank").distinct.joins("INNER JOIN moster_types ON (moster_types.name = monsters.type)").order("moster_types.rank #{sort_direction}").uniq

    else
      @monsters = @user.monsters.order(sort_column + " " + sort_direction)
    end   
  end

  def show
  end

  def new
    @user     = User.find_by(id: params['user_id'])
    def_team  = @user.teams.where(status: 'default').first
    @team     = Team.find_by(id: def_team.id)
    @monster  = Monster.new
  end

  def edit
    @user    = User.find_by(id: params['user_id'])
    @monster = Monster.find(params[:id])
    @team    = Team.find_by(id: @monster.team_id)
  end

  def create
    @monster  = Monster.new(monster_params)
    @user     = User.find_by(id: params['user_id'])
    def_team  = @user.teams.where(status: 'default').first
    @team     = Team.find_by(id: def_team.id)
    respond_to do |format|
      if @monster.save
        format.html { redirect_to user_monsters_url(@user), notice: 'Monster was successfully created.' }
        format.json { render :show, status: :created, location: @monster }
      else
        format.html { render :new }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @monster = Monster.find(params[:id])
    @team    = Team.find_by(id: @monster.team_id)
    @user    = User.find_by(id: params['user_id'])
    respond_to do |format|
      if @monster.update(monster_params)
        format.html { redirect_to user_monsters_url, notice: 'Monster was successfully updated.' }
        format.json { render :show, status: :ok, location: @monster }
        format.js { }
      else
        format.html { render :edit }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find_by(id: params['user_id'])
    @monster.destroy
    respond_to do |format|
      format.html { redirect_to user_monsters_url(@user, @monster), notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_team
    @teams   = Team.where("status = ? AND user_id = ?", 'manual', params[:user_id])
    @monster = Monster.find(params[:id])
    @user    = User.find_by(id: params['user_id'])

    respond_to do |format|
      format.js
    end
  end

  def change_team
  end

  private

    def set_monster
      @monster = Monster.find(params[:id])
    end

    def monster_params
      params.require(:monster).permit(:name, :power, :type, :team_id)
    end

    def sort_column
      Monster.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
